import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakulog/app/app.dart';
import 'package:otakulog/core/config/cloud_config.dart';
import 'package:otakulog/core/config/cloud_runtime.dart';
import 'package:otakulog/core/services/reminder_service.dart';
import 'package:otakulog/core/services/background_sync_manager.dart';
import 'package:otakulog/data/local/retention_preferences_service.dart';
import 'package:otakulog/data/local/isar_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: '.env');
  } catch (_) {
    // Missing env keeps the app in local-only mode.
  }

  final cloudConfig = CloudConfig.fromEnv();
  if (cloudConfig.isValid) {
    await Supabase.initialize(
      url: cloudConfig.url,
      anonKey: cloudConfig.anonKey,
    );
    CloudRuntime.isConfigured = true;
  }

  await IsarService.init();
  await ReminderService().initialize();
  
  try {
    await BackgroundSyncManager.initialize();
    final prefs = await RetentionPreferencesService().load();
    await BackgroundSyncManager.updateSchedule(prefs.webdavSyncFrequency);
  } catch (_) {}
  
  runApp(
    const ProviderScope(
      child: GoonTrackerApp(),
    ),
  );
}
