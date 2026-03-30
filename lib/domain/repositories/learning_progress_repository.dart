import 'package:flutter_journey/domain/models/learning_progress_snapshot.dart';

abstract class LearningProgressRepository {
  Future<LearningProgressSnapshot> load();

  Future<void> save({
    required Set<String> learnedLessonIds,
    required Set<String> earnedBadgeIds,
    required Map<String, DateTime> lessonCompletedAt,
  });
}
