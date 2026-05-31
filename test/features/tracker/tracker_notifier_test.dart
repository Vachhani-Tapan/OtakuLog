import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import 'package:otakulog/app/providers.dart';
import 'package:otakulog/domain/entities/anime.dart';
import 'package:otakulog/domain/entities/manga.dart';
import 'package:otakulog/domain/entities/user_session.dart';
import 'package:otakulog/domain/repositories/anime_repository.dart';
import 'package:otakulog/domain/repositories/manga_repository.dart';
import 'package:otakulog/domain/repositories/session_repository.dart';
import 'package:otakulog/domain/repositories/tracker_repository.dart';
import 'package:otakulog/features/tracker/tracker_notifier.dart';

//the release cap test for anime checks result!.message.contains('Only') a string-match assertion. 
// If rename that message string it'll silently break the test. 

class MockAnimeRepository extends Mock implements AnimeRepository {}

class MockMangaRepository extends Mock implements MangaRepository {}

class MockSessionRepository extends Mock implements SessionRepository {}

class MockTrackerRepository extends Mock implements TrackerRepository {}

class FakeAnimeEntity extends Fake implements AnimeEntity {}

class FakeMangaEntity extends Fake implements MangaEntity {}

class FakeUserSessionEntity extends Fake implements UserSessionEntity {}

void main() {
  late MockAnimeRepository animeRepository;
  late MockMangaRepository mangaRepository;
  late MockSessionRepository sessionRepository;
  late MockTrackerRepository trackerRepository;

  setUpAll(() {
    registerFallbackValue(FakeAnimeEntity());
    registerFallbackValue(FakeMangaEntity());
    registerFallbackValue(FakeUserSessionEntity());
  });

  AnimeEntity anime({
    int currentEpisode = 2,
    int totalEpisodes = 12,
    double? rating,
  }) {
    final now = DateTime(2026, 1, 1);

    return AnimeEntity(
      id: 'anime-1',
      title: 'Test Anime',
      coverImage: '',
      totalEpisodes: totalEpisodes,
      currentEpisode: currentEpisode,
      status: AnimeStatus.watching,
      rating: rating,
      genres: const [],
      description: null,
      createdAt: now,
      updatedAt: now,
    );
  }

  MangaEntity manga({
    int currentChapter = 5,
    int totalChapters = 50,
    double? rating,
  }) {
    final now = DateTime(2026, 1, 1);

    return MangaEntity(
      id: 'manga-1',
      title: 'Test Manga',
      coverImage: '',
      totalChapters: totalChapters,
      currentChapter: currentChapter,
      status: MangaStatus.reading,
      rating: rating,
      genres: const [],
      description: null,
      isAdult: false,
      createdAt: now,
      updatedAt: now,
    );
  }

  ProviderContainer createContainer({
    int? animeReleaseCap = 12,
    int? mangaReleaseCap = 50,
  }) {
    animeRepository = MockAnimeRepository();
    mangaRepository = MockMangaRepository();
    sessionRepository = MockSessionRepository();
    trackerRepository = MockTrackerRepository();

    when(() => sessionRepository.saveSession(any()))
        .thenAnswer((_) async => true);

    when(() => sessionRepository.deleteSession(any()))
        .thenAnswer((_) async => true);

    when(
      () => trackerRepository.logActivity(
        any(),
        minutesWatched: any(named: 'minutesWatched'),
        minutesRead: any(named: 'minutesRead'),
      ),
    ).thenAnswer((_) async {});

    when(() => animeRepository.saveAnime(any())).thenAnswer((_) async => true);

    when(() => mangaRepository.saveManga(any())).thenAnswer((_) async => true);

    when(() => animeRepository.deleteAnime(any()))
        .thenAnswer((_) async => true);

    when(() => mangaRepository.deleteManga(any()))
        .thenAnswer((_) async => true);
    when(() => animeRepository.getAllAnime()).thenAnswer((_) async => []);

    when(() => mangaRepository.getAllManga()).thenAnswer((_) async => []);

    when(() => sessionRepository.getAllSessions()).thenAnswer((_) async => []);

    when(() => sessionRepository.getRecentSessions())
        .thenAnswer((_) async => []);

    final testManga = manga();

    final container = ProviderContainer(
      overrides: [
        animeRepositoryProvider.overrideWithValue(animeRepository),
        mangaRepositoryProvider.overrideWithValue(mangaRepository),
        sessionRepositoryProvider.overrideWithValue(sessionRepository),
        trackerRepositoryProvider.overrideWithValue(trackerRepository),
        animeReleaseCapProvider('anime-1').overrideWith(
          (ref) async => animeReleaseCap,
        ),
        mangaReleaseCapForMangaProvider(
          MangaReleaseCapLookup(
            mangaId: testManga.id,
            coverImageUrl: testManga.coverImage,
            title: testManga.title,
          ),
        ).overrideWith(
          (ref) async => mangaReleaseCap,
        ),
      ],
    );

    addTearDown(container.dispose);
    return container;
  }

  group('TrackerNotifier', () {
    test('logAnimeEpisode increments currentEpisode by 1', () async {
      final container = createContainer();
      final notifier = container.read(trackerNotifierProvider.notifier);

      await notifier.logAnimeEpisode(anime(currentEpisode: 2));

      verify(
        () => animeRepository.saveAnime(
          any(
            that: predicate<AnimeEntity>(
              (saved) => saved.currentEpisode == 3,
            ),
          ),
        ),
      ).called(1);
    });

    test('logAnimeEpisode does not increment past the release cap', () async {
      final container = createContainer(animeReleaseCap: 3);
      final notifier = container.read(trackerNotifierProvider.notifier);

      final result = await notifier.logAnimeEpisode(
        anime(
          currentEpisode: 3,
          totalEpisodes: 3,
        ),
      );

      expect(result, isNotNull);
      expect(result!.message, contains('Only'));

      verifyNever(() => sessionRepository.saveSession(any()));
    });
    test('logMangaChapter increments currentChapter by 1', () async {
      final container = createContainer();
      final notifier = container.read(trackerNotifierProvider.notifier);

      await notifier.logMangaChapter(manga(currentChapter: 5));

      verify(
        () => mangaRepository.saveManga(
          any(
            that: predicate<MangaEntity>(
              (saved) => saved.currentChapter == 6,
            ),
          ),
        ),
      ).called(1);
    });

    test('logMangaToChapter sets currentChapter to target value', () async {
      final container = createContainer();
      final notifier = container.read(trackerNotifierProvider.notifier);

      await notifier.logMangaToChapter(manga(currentChapter: 5), 10);

      verify(
        () => mangaRepository.saveManga(
          any(
            that: predicate<MangaEntity>(
              (saved) => saved.currentChapter == 10,
            ),
          ),
        ),
      ).called(1);
    });

    test('logMangaToChapter does not set chapter below current progress',
        () async {
      final container = createContainer();
      final notifier = container.read(trackerNotifierProvider.notifier);

      await notifier.logMangaToChapter(manga(currentChapter: 10), 5);

      verifyNever(() => mangaRepository.saveManga(any()));
      verifyNever(() => sessionRepository.saveSession(any()));
    });

    test('updateRating saves the correct rating value', () async {
      final container = createContainer();
      final notifier = container.read(trackerNotifierProvider.notifier);

      await notifier.updateRating(anime(), 8.5);

      verify(
        () => animeRepository.saveAnime(
          any(
            that: predicate<AnimeEntity>(
              (saved) => saved.rating == 8.5,
            ),
          ),
        ),
      ).called(1);
    });

    test('removeFromLibrary removes the item correctly', () async {
      final container = createContainer();
      final notifier = container.read(trackerNotifierProvider.notifier);

      await notifier.removeFromLibrary(manga());

      verify(() => mangaRepository.deleteManga('manga-1')).called(1);
      verifyNever(() => animeRepository.deleteAnime(any()));
    });
  });
}
