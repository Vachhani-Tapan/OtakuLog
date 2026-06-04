import 'package:flutter_test/flutter_test.dart';
import 'package:otakulog/data/local/retention_preferences_service.dart';

void main() {
  group('WebDAV Status & Preference Serialization Tests', () {
    test('RetentionPreferences should successfully serialize and deserialize WebDAV status fields', () {
      const preferences = RetentionPreferences(
        notificationsEnabled: false,
        webdavLastSyncedAtIso: '2026-06-03T12:00:00.000Z',
        webdavLastError: '401 Unauthorized',
      );

      final json = preferences.toJson();
      
      expect(json['webdavLastSyncedAtIso'], '2026-06-03T12:00:00.000Z');
      expect(json['webdavLastError'], '401 Unauthorized');
      // Verify credentials are not serialized inside plaintext preferences
      expect(json['webdavUrl'], isNull);
      expect(json['webdavUsername'], isNull);
      expect(json['webdavPassword'], isNull);

      final deserialized = RetentionPreferences.fromJson(json);

      expect(deserialized.webdavLastSyncedAtIso, '2026-06-03T12:00:00.000Z');
      expect(deserialized.webdavLastError, '401 Unauthorized');
      expect(deserialized.webdavLastSyncedAt, isNotNull);
      expect(deserialized.webdavLastSyncedAt!.year, 2026);
    });

    test('RetentionPreferences copyWith should cleanly update WebDAV status fields', () {
      const preferences = RetentionPreferences();
      
      final updated = preferences.copyWith(
        webdavLastSyncedAtIso: '2026-06-03T22:00:00.000Z',
        webdavLastError: '',
      );

      expect(updated.webdavLastSyncedAtIso, '2026-06-03T22:00:00.000Z');
      expect(updated.webdavLastError, isEmpty);
    });
  });
}
