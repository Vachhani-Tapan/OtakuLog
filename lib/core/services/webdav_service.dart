import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import 'package:webdav_client/webdav_client.dart' as webdav;
import 'package:otakulog/data/local/retention_preferences_service.dart';
import 'package:otakulog/data/mappers/activity_mapper.dart';
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

class WebDavService {
  final UserRepository userRepository;
  final AnimeRepository animeRepository;
  final MangaRepository mangaRepository;
  final SessionRepository sessionRepository;
  final RetentionPreferencesService retentionPreferencesService;
  final BackupMapper backupMapper;
  final SyncService syncService;
  final Isar isar;
  final FlutterSecureStorage secureStorage;

  WebDavService({
    required this.userRepository,
    required this.animeRepository,
    required this.mangaRepository,
    required this.sessionRepository,
    required this.retentionPreferencesService,
    required this.backupMapper,
    required this.syncService,
    required this.isar,
    required this.secureStorage,
  });

  webdav.Client _buildClient(String url, String username, String password) {
    var targetUrl = url.trim();
    if (!targetUrl.startsWith('http://') && !targetUrl.startsWith('https://')) {
      targetUrl = 'https://$targetUrl';
    }
    return webdav.newClient(
      targetUrl,
      user: username.trim(),
      password: password,
      debug: false,
    );
  }

  Future<bool> testConnection(String url, String username, String password) async {
    if (url.trim().isEmpty) return false;
    try {
      final client = _buildClient(url, username, password);
      await client.readDir('/');
      return true;
    } catch (e) {
      throw Exception('Connection failed: $e');
    }
  }

  Future<void> syncNow({required RestoreMode mode}) async {
    final url = await secureStorage.read(key: 'webdav_url');
    final username = await secureStorage.read(key: 'webdav_username');
    final password = await secureStorage.read(key: 'webdav_password');

    if (url == null || url.trim().isEmpty || username == null || username.trim().isEmpty || password == null || password.trim().isEmpty) {
      throw Exception('WebDAV sync credentials are not configured.');
    }

    final client = _buildClient(url, username, password);
    final tempDir = await getTemporaryDirectory();
    final localTempFile = File('${tempDir.path}/otakulog_webdav_temp_${DateTime.now().millisecondsSinceEpoch}.json');

    try {
      bool remoteFileExists = false;
      try {
        await client.read2File('/otakulog_backup.json', localTempFile.path);
        remoteFileExists = true;
      } catch (e) {
        remoteFileExists = false;
      }

      if (remoteFileExists && await localTempFile.exists()) {
        final content = await localTempFile.readAsString();
        if (content.trim().isNotEmpty) {
          Map<String, dynamic> json;
          try {
            json = jsonDecode(content) as Map<String, dynamic>;
          } catch (e) {
            throw const FormatException('The remote backup file is not valid JSON.');
          }

          if (!json.containsKey('schemaVersion') || !json.containsKey('exportedAt')) {
            throw const FormatException('The remote backup file is missing required metadata.');
          }

          final payload = BackupPayload.fromJson(json);
          if (payload.schemaVersion > BackupPayload.currentSchemaVersion) {
            throw FormatException(
              'The remote backup was created by a newer version of the app (schema v${payload.schemaVersion}). '
              'Please update the app before syncing.',
            );
          }

          await syncService.mergeData(payload, mode: mode);
        }
      }

      final profile = await userRepository.getUser('local_user');
      final animeList = await animeRepository.getAllAnime();
      final mangaList = await mangaRepository.getAllManga();
      final library = [...animeList, ...mangaList];
      final sessions = await sessionRepository.getAllSessions();
      final streaks = (await isar.dailyActivitys.where().findAll())
          .map(ActivityMapper.toEntity)
          .toList();
      final currentPrefs = await retentionPreferencesService.load();

      final updatedPayload = backupMapper.exportPayload(
        profile: profile,
        library: library,
        sessions: sessions,
        streaks: streaks,
        retentionPreferences: currentPrefs,
      );

      final jsonString = jsonEncode(updatedPayload.toJson());
      final uploadTempFile = File('${tempDir.path}/otakulog_webdav_upload_${DateTime.now().millisecondsSinceEpoch}.json');
      await uploadTempFile.writeAsString(jsonString);

      await client.writeFromFile(uploadTempFile.path, '/otakulog_backup.json');

      final finalPrefs = await retentionPreferencesService.load();
      await retentionPreferencesService.save(
        finalPrefs.copyWith(
          webdavLastSyncedAtIso: DateTime.now().toIso8601String(),
          webdavLastError: '',
        ),
      );

      try {
        if (await localTempFile.exists()) await localTempFile.delete();
        if (await uploadTempFile.exists()) await uploadTempFile.delete();
      } catch (_) {}
    } catch (e) {
      final errorMsg = e.toString().replaceAll('Exception: ', '');
      final finalPrefs = await retentionPreferencesService.load();
      await retentionPreferencesService.save(
        finalPrefs.copyWith(
          webdavLastError: errorMsg,
        ),
      );
      try {
        if (await localTempFile.exists()) await localTempFile.delete();
      } catch (_) {}
      rethrow;
    }
  }
}
