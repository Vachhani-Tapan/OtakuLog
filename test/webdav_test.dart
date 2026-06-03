import 'package:flutter_test/flutter_test.dart';
import 'package:otakulog/data/local/retention_preferences_service.dart';

void main() {
  group('WebDAV Configuration & Preference Serialization Tests', () {
    test('RetentionPreferences should successfully serialize and deserialize WebDAV configurations', () {
      const preferences = RetentionPreferences(
        notificationsEnabled: false,
        webdavUrl: 'https://nextcloud.myhost.com/remote.php/dav/files/user/',
        webdavUsername: 'dhruv',
        webdavPassword: 'app-specific-token-123',
        webdavLastSyncedAtIso: '2026-06-03T12:00:00.000Z',
        webdavLastError: '401 Unauthorized',
      );

      final json = preferences.toJson();
      
      expect(json['webdavUrl'], 'https://nextcloud.myhost.com/remote.php/dav/files/user/');
      expect(json['webdavUsername'], 'dhruv');
      expect(json['webdavPassword'], 'app-specific-token-123');
      expect(json['webdavLastSyncedAtIso'], '2026-06-03T12:00:00.000Z');
      expect(json['webdavLastError'], '401 Unauthorized');

      final deserialized = RetentionPreferences.fromJson(json);

      expect(deserialized.webdavUrl, 'https://nextcloud.myhost.com/remote.php/dav/files/user/');
      expect(deserialized.webdavUsername, 'dhruv');
      expect(deserialized.webdavPassword, 'app-specific-token-123');
      expect(deserialized.webdavLastSyncedAtIso, '2026-06-03T12:00:00.000Z');
      expect(deserialized.webdavLastError, '401 Unauthorized');
      expect(deserialized.webdavLastSyncedAt, isNotNull);
      expect(deserialized.webdavLastSyncedAt!.year, 2026);
    });

    test('RetentionPreferences copyWith should cleanly update WebDAV configuration options', () {
      const preferences = RetentionPreferences();
      
      final updated = preferences.copyWith(
        webdavUrl: 'https://dav.box.com/dav',
        webdavUsername: 'backup_user',
        webdavPassword: 'password123',
      );

      expect(updated.webdavUrl, 'https://dav.box.com/dav');
      expect(updated.webdavUsername, 'backup_user');
      expect(updated.webdavPassword, 'password123');
      expect(updated.webdavLastSyncedAtIso, isNull);
      
      final synced = updated.copyWith(
        webdavLastSyncedAtIso: '2026-06-03T22:00:00.000Z',
        webdavLastError: '',
      );

      expect(synced.webdavUrl, 'https://dav.box.com/dav');
      expect(synced.webdavLastSyncedAtIso, '2026-06-03T22:00:00.000Z');
      expect(synced.webdavLastError, isEmpty);
    });
  });
}
