import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:isar/isar.dart';
import 'package:otakulog/data/local/retention_preferences_service.dart';
import 'package:otakulog/data/models/daily_activity.dart';
import 'package:otakulog/domain/entities/activity.dart';
import 'package:otakulog/domain/entities/trackable_content.dart';
import 'package:otakulog/domain/entities/user.dart';
import 'package:otakulog/domain/entities/user_session.dart';
import 'package:otakulog/domain/repositories/anime_repository.dart';
import 'package:otakulog/domain/repositories/manga_repository.dart';
import 'package:otakulog/domain/repositories/session_repository.dart';
import 'package:otakulog/domain/repositories/user_repository.dart';
import 'package:otakulog/data/remote/backup_mapper.dart';
import 'package:otakulog/core/services/sync_service.dart';
import 'package:otakulog/features/cloud/models/backup_payload.dart';

class LocalBackupService {
  final UserRepository userRepository;
  final AnimeRepository animeRepository;
  final MangaRepository mangaRepository;
  final SessionRepository sessionRepository;
  final RetentionPreferencesService retentionPreferencesService;
  final BackupMapper backupMapper;
  final SyncService syncService;
  final Isar isar;

  LocalBackupService({
    required this.userRepository,
    required this.animeRepository,
    required this.mangaRepository,
    required this.sessionRepository,
    required this.retentionPreferencesService,
    required this.backupMapper,
    required this.syncService,
    required this.isar,
  });

  /// Exports local data into a JSON file, either using saveFile picker (desktop) or Share (mobile).
  Future<bool> exportBackup() async {
    try {
      final profile = await userRepository.getUser('local_user');
      final animeList = await animeRepository.getAllAnime();
      final mangaList = await mangaRepository.getAllManga();
      final library = [...animeList, ...mangaList];
      final sessions = await sessionRepository.getAllSessions();
      final streaks = (await isar.dailyActivitys.where().findAll())
          .map((e) => e.toEntity())
          .toList();
      final retentionPreferences = await retentionPreferencesService.load();

      final payload = backupMapper.exportPayload(
        profile: profile,
        library: library,
        sessions: sessions,
        streaks: streaks,
        retentionPreferences: retentionPreferences,
      );

      final jsonString = jsonEncode(payload.toJson());

      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        final outputFile = await FilePicker.platform.saveFile(
          dialogTitle: 'Select where to save backup',
          fileName: 'otakulog_backup_${DateTime.now().millisecondsSinceEpoch}.json',
          type: FileType.custom,
          allowedExtensions: ['json'],
        );

        if (outputFile == null) {
          return false; // User cancelled
        }

        final file = File(outputFile);
        await file.writeAsString(jsonString);
        return true;
      } else {
        // Mobile platform (Android, iOS)
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/otakulog_backup.json');
        await file.writeAsString(jsonString);

        await Share.shareXFiles(
          [XFile(file.path)],
          subject: 'OtakuLog Backup',
          text: 'Here is your OtakuLog local backup file.',
        );
        return true;
      }
    } catch (e) {
      throw Exception('Failed to export backup: $e');
    }
  }

  /// Picks a JSON backup file and runs integrity validations.
  /// Returns a [BackupPayload] if successful.
  Future<BackupPayload?> pickAndValidateBackup() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result == null || result.files.single.path == null) {
        return null; // User cancelled
      }

      final file = File(result.files.single.path!);
      final content = await file.readAsString();
      
      // Structural validations:
      Map<String, dynamic> json;
      try {
        json = jsonDecode(content) as Map<String, dynamic>;
      } catch (e) {
        throw const FormatException('The selected file is not a valid JSON file.');
      }

      // Check required fields for schema integrity:
      if (!json.containsKey('schemaVersion') || !json.containsKey('exportedAt')) {
        throw const FormatException('The selected backup file is missing required metadata (schemaVersion, exportedAt).');
      }

      if (!json.containsKey('library') || !json.containsKey('sessions')) {
        throw const FormatException('The selected backup file is missing core collections data (library, sessions).');
      }

      final payload = BackupPayload.fromJson(json);

      if (payload.schemaVersion > BackupPayload.currentSchemaVersion) {
        throw FormatException(
          'This backup was created by a newer version of the app (schema v${payload.schemaVersion}). '
          'Please update the app before importing.',
        );
      }

      return payload;
    } catch (e) {
      if (e is FormatException) {
        rethrow;
      }
      throw Exception('Failed to import backup: $e');
    }
  }

  /// Executes restore/merge logic on the validated payload.
  Future<void> restoreBackup(BackupPayload payload, RestoreMode mode) async {
    try {
      await syncService.mergeData(payload, mode: mode);
      
      // Update retention preferences' last backup/restore timestamp if applicable
      final preferences = await retentionPreferencesService.load();
      await retentionPreferencesService.save(
        preferences.copyWith(
          lastBackupAtIso: DateTime.now().toIso8601String(),
        ),
      );
    } catch (e) {
      throw Exception('Failed to restore backup: $e');
    }
  }
}
