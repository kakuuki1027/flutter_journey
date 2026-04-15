import 'package:flutter_journey/domain/models/learning_lesson.dart';
import 'package:flutter_journey/domain/models/learning_progress_snapshot.dart';
import 'package:flutter_journey/domain/repositories/learning_progress_repository.dart';
import 'package:flutter_journey/features/learning/learning_controller.dart';
import 'package:flutter_test/flutter_test.dart';

class _InMemoryLearningProgressRepository
    implements LearningProgressRepository {
  LearningProgressSnapshot _snapshot = const LearningProgressSnapshot(
    learnedLessonIds: <String>{},
    earnedBadgeIds: <String>{},
    lessonCompletedAt: <String, DateTime>{},
  );

  @override
  Future<LearningProgressSnapshot> load() async => _snapshot;

  @override
  Future<void> save({
    required Set<String> learnedLessonIds,
    required Set<String> earnedBadgeIds,
    required Map<String, DateTime> lessonCompletedAt,
  }) async {
    _snapshot = LearningProgressSnapshot(
      learnedLessonIds: {...learnedLessonIds},
      earnedBadgeIds: {...earnedBadgeIds},
      lessonCompletedAt: {...lessonCompletedAt},
    );
  }
}

void main() {
  test('earning a lesson unlocks a badge and persists progress', () async {
    final repository = _InMemoryLearningProgressRepository();
    final controller = LearningController(
      progressRepository: repository,
      lessons: const [
        LearningLesson(id: 'i1', title: 'レイアウトの基本', category: 'リポジトリ'),
        LearningLesson(id: 'v1', title: 'Flutter ウィジェット入門', category: '動画'),
      ],
    );

    await controller.load();
    final badges = await controller.markLessonLearned('i1');

    expect(controller.isLessonLearned('i1'), isTrue);
    expect(controller.learnedLessonsCount, 1);
    expect(badges.map((badge) => badge.id), contains('i1'));

    final snapshot = await repository.load();
    expect(snapshot.learnedLessonIds, contains('i1'));
    expect(snapshot.earnedBadgeIds, contains('i1'));
    expect(snapshot.lessonCompletedAt.keys, contains('i1'));
  });

  test('earning all lessons grants the completion badge', () async {
    final controller = LearningController(
      progressRepository: _InMemoryLearningProgressRepository(),
      lessons: const [
        LearningLesson(id: 'i1', title: 'レイアウトの基本', category: 'リポジトリ'),
        LearningLesson(id: 'v1', title: 'Flutter ウィジェット入門', category: '動画'),
      ],
    );

    await controller.load();
    await controller.markLessonLearned('i1');
    final finalBadges = await controller.markLessonLearned('v1');

    expect(controller.hasCompletedAllLessons, isTrue);
    expect(
      finalBadges.map((badge) => badge.id),
      contains(LearningController.completionBadgeId),
    );
    expect(
      controller.earnedBadges.map((badge) => badge.id),
      contains(LearningController.completionBadgeId),
    );
  });

  test('streak counts consecutive learning days from local progress', () async {
    final controller = LearningController(
      progressRepository: _InMemoryLearningProgressRepository()
        .._snapshot = LearningProgressSnapshot(
          learnedLessonIds: const {'i1', 'v1', 'l1'},
          earnedBadgeIds: const {'i1', 'v1', 'l1'},
          lessonCompletedAt: {
            'i1': DateTime(2026, 3, 28, 10),
            'v1': DateTime(2026, 3, 29, 11),
            'l1': DateTime(2026, 3, 30, 12),
          },
        ),
      lessons: const [
        LearningLesson(id: 'i1', title: 'レイアウトの基本', category: 'リポジトリ'),
        LearningLesson(id: 'v1', title: 'Flutter ウィジェット入門', category: '動画'),
        LearningLesson(id: 'l1', title: 'Flutter 公式ドキュメント', category: 'ウェブ'),
      ],
      now: () => DateTime(2026, 3, 30, 15),
    );

    await controller.load();

    expect(controller.currentStreakDays, 3);
    expect(controller.recentLessons.first.id, 'l1');
    expect(controller.completedAtLabel('l1'), '今日完了');
  });
}
