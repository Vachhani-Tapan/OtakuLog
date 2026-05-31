import 'package:flutter_test/flutter_test.dart';
import 'package:otakulog/domain/entities/activity.dart';
import 'package:otakulog/domain/entities/anime.dart';
import 'package:otakulog/domain/entities/user.dart';
import 'package:otakulog/domain/entities/user_session.dart';
import 'package:otakulog/data/local/retention_preferences_service.dart';
import 'package:otakulog/data/remote/backup_mapper.dart';
import 'package:otakulog/features/cloud/models/backup_payload.dart';

void main() {
  group('Local Backup & Restore Mappings & Serialization', () {
    late BackupMapper mapper;
    late DateTime now;

    setUp(() {
      mapper = BackupMapper();
      now = DateTime(2026, 5, 31, 12, 0, 0);
    });

    test('BackupPayload toJson/fromJson should roundtrip daily activity streaks', () {
      final payload = BackupPayload(
        exportedAt: now,
        lastWriteTimestamp: now,
        profile: const {
          'id': 'local_user',
          'name': 'Dhruv',
        },
        library: [
          {
            'kind': 'anime',
            'id': '1',
            'title': 'Frieren',
            'coverImage': 'img.jpg',
            'totalEpisodes': 28,
            'currentEpisode': 28,
            'status': 'completed',
            'genres': const ['Fantasy', 'Adventure'],
            'createdAt': now.toIso8601String(),
            'updatedAt': now.toIso8601String(),
          }
        ],
        sessions: [
          {
            'id': 'sess1',
            'contentId': '1',
            'contentType': 'anime',
            'startTime': now.toIso8601String(),
            'endTime': now.toIso8601String(),
            'unitsConsumed': 1,
          }
        ],
        retentionPreferences: const {
          'notificationsEnabled': true,
          'preferDataSaverDownloads': false,
        },
        streaks: [
          {
            'id': 10,
            'date': now.toIso8601String(),
            'minutesWatched': 30,
            'minutesRead': 15,
          }
        ],
      );

      final json = payload.toJson();
      final decoded = BackupPayload.fromJson(json);

      expect(decoded.schemaVersion, BackupPayload.currentSchemaVersion);
      expect(decoded.exportedAt, now);
      expect(decoded.profile?['name'], 'Dhruv');
      expect(decoded.library.first['title'], 'Frieren');
      expect(decoded.sessions.first['id'], 'sess1');
      expect(decoded.retentionPreferences?['notificationsEnabled'], true);
      
      // Verify streaks roundtrip
      expect(decoded.streaks.length, 1);
      expect(decoded.streaks.first['id'], 10);
      expect(decoded.streaks.first['minutesWatched'], 30);
      expect(decoded.streaks.first['minutesRead'], 15);
    });

    test('BackupPayload fromJson should be backwards compatible with old formats missing streaks', () {
      final json = {
        'schemaVersion': 1,
        'exportedAt': now.toIso8601String(),
        'lastWriteTimestamp': now.toIso8601String(),
        'profile': const {'id': '1', 'name': 'Old Backup'},
        'library': const [],
        'sessions': const [],
        'retentionPreferences': null,
      };

      final decoded = BackupPayload.fromJson(json);
      expect(decoded.profile?['name'], 'Old Backup');
      expect(decoded.streaks, isEmpty); // Should default to empty list!
    });

    test('BackupMapper should map entities including streaks correctly', () {
      final profile = UserEntity(
        id: 'local_user',
        name: 'Dhruv',
        avatarPath: 'avatar.png',
        createdAt: now,
        updatedAt: now,
      );

      final library = [
        AnimeEntity(
          id: '1',
          title: 'Frieren',
          coverImage: 'img.jpg',
          totalEpisodes: 28,
          currentEpisode: 28,
          status: AnimeStatus.completed,
          genres: const ['Fantasy'],
          createdAt: now,
          updatedAt: now,
        ),
      ];

      final sessions = [
        UserSessionEntity(
          id: 'sess1',
          contentId: '1',
          contentType: SessionContentType.anime,
          startTime: now,
          endTime: now,
          unitsConsumed: 1,
        ),
      ];

      final streaks = [
        Activity(
          id: 10,
          date: now,
          minutesWatched: 30,
          minutesRead: 15,
        ),
      ];

      final payload = mapper.exportPayload(
        profile: profile,
        library: library,
        sessions: sessions,
        streaks: streaks,
        retentionPreferences: const RetentionPreferences(),
      );

      // Verify BackupPreview
      final preview = mapper.buildPreview(payload);
      expect(preview.profileName, 'Dhruv');
      expect(preview.libraryCount, 1);
      expect(preview.sessionsCount, 1);
      expect(preview.streaksCount, 1);

      // Verify streaks mapping back from payload
      final streaksFromBackup = mapper.streaksFromPayload(payload);
      expect(streaksFromBackup.length, 1);
      expect(streaksFromBackup.first.id, 10);
      expect(streaksFromBackup.first.minutesWatched, 30);
      expect(streaksFromBackup.first.minutesRead, 15);
    });
  });
}
