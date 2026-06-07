import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';

import 'package:otakulog/data/local/retention_preferences_service.dart';
import 'package:otakulog/data/models/anime_model.dart';
import 'package:otakulog/data/models/manga_model.dart';
import 'package:otakulog/data/models/user_model.dart';
import 'package:otakulog/data/models/daily_activity.dart';
import 'package:otakulog/data/models/user_session_model.dart';
import 'package:otakulog/data/models/achievement_model.dart';

import 'package:otakulog/core/services/webdav_service.dart';
import 'package:otakulog/data/repositories/anime_repository_impl.dart';
import 'package:otakulog/data/repositories/manga_repository_impl.dart';
import 'package:otakulog/data/repositories/session_repository_impl.dart';
import 'package:otakulog/data/repositories/user_repository_impl.dart';
import 'package:otakulog/data/remote/backup_mapper.dart';
import 'package:otakulog/data/remote/backup_service.dart';
import 'package:otakulog/core/services/sync_service.dart';
import 'package:otakulog/features/cloud/models/backup_payload.dart';

const String backgroundSyncTaskName = "com.otakulog.background_webdav_sync";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();
    Isar? isar;
    try {
      // 1. Check internet connectivity
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isEmpty || result[0].rawAddress.isEmpty) {
          debugPrint("Offline: skipping background sync task.");
          return Future.value(true);
        }
      } catch (_) {
        debugPrint("Offline: skipping background sync task.");
        return Future.value(true);
      }

      // 2. Load credentials securely
      const secureStorage = FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      );
      final url = await secureStorage.read(key: 'webdav_url');
      final username = await secureStorage.read(key: 'webdav_username');
      final password = await secureStorage.read(key: 'webdav_password');

      if (url == null || url.trim().isEmpty || username == null || username.trim().isEmpty || password == null || password.trim().isEmpty) {
        debugPrint("Background sync cancelled: credentials missing.");
        return Future.value(true);
      }

      // 3. Initialize Isar
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
        [
          AnimeModelSchema,
          MangaModelSchema,
          UserModelSchema,
          DailyActivitySchema,
          UserSessionModelSchema,
          AchievementModelSchema,
        ],
        directory: dir.path,
        name: 'default',
      );

      // 4. Set up repositories and services
      final userRepo = UserRepositoryImpl(isar);
      final animeRepo = AnimeRepositoryImpl(isar);
      final mangaRepo = MangaRepositoryImpl(isar);
      final sessionRepo = SessionRepositoryImpl(isar);
      final prefsService = RetentionPreferencesService();
      final backupMapper = BackupMapper();

      // Placeholder dummy backupService, since SyncService uses supabase backupService.
      // But WebDavService uses SyncService's mergeData. WebDavService's syncNow itself manages WebDAV connection.
      final dummyBackupService = BackupService(client: null);
      final syncService = SyncService(
        backupService: dummyBackupService,
        backupMapper: backupMapper,
        retentionPreferencesService: prefsService,
        isar: isar,
      );

      final webdavService = WebDavService(
        userRepository: userRepo,
        animeRepository: animeRepo,
        mangaRepository: mangaRepo,
        sessionRepository: sessionRepo,
        retentionPreferencesService: prefsService,
        backupMapper: backupMapper,
        syncService: syncService,
        isar: isar,
        secureStorage: secureStorage,
      );

      // 5. Execute synchronization
      await webdavService.syncNow(mode: RestoreMode.merge);

      debugPrint("Background sync execution finished successfully.");
      return Future.value(true);
    } catch (e) {
      debugPrint("Background sync failed: $e");
      // Record failure through RetentionPreferencesService
      try {
        final prefsService = RetentionPreferencesService();
        final prefs = await prefsService.load();
        await prefsService.save(
          prefs.copyWith(
            webdavLastError: e.toString().replaceAll('Exception: ', ''),
          ),
        );
      } catch (_) {}
      return Future.value(false);
    } finally {
      if (isar != null && isar.isOpen) {
        await isar.close();
      }
    }
  });
}

class BackgroundSyncManager {
  static Future<void> initialize() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );
  }

  static Future<void> updateSchedule(String frequency) async {
    await Workmanager().cancelAll();
    if (frequency == '12h') {
      await Workmanager().registerPeriodicTask(
        backgroundSyncTaskName,
        backgroundSyncTaskName,
        frequency: const Duration(hours: 12),
        existingWorkPolicy: ExistingPeriodicWorkPolicy.update,
        constraints: Constraints(
          networkType: NetworkType.connected,
          requiresBatteryNotLow: true,
        ),
      );
      debugPrint("Registered background sync task: every 12 hours");
    } else if (frequency == '24h') {
      await Workmanager().registerPeriodicTask(
        backgroundSyncTaskName,
        backgroundSyncTaskName,
        frequency: const Duration(hours: 24),
        existingWorkPolicy: ExistingPeriodicWorkPolicy.update,
        constraints: Constraints(
          networkType: NetworkType.connected,
          requiresBatteryNotLow: true,
        ),
      );
      debugPrint("Registered background sync task: every 24 hours");
    } else {
      debugPrint("Background sync frequency set to Off. All scheduled tasks cancelled.");
    }
  }
}
