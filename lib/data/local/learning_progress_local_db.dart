import 'package:flutter_journey/domain/models/learning_progress_snapshot.dart';
import 'package:flutter_journey/domain/repositories/learning_progress_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LearningProgressLocalDb implements LearningProgressRepository {
  LearningProgressLocalDb(this._box);

  static const boxName = 'learning_progress';
  static const _learnedLessonsKey = 'learned_lessons';
  static const _earnedBadgesKey = 'earned_badges';
  static const _lessonCompletedAtKey = 'lesson_completed_at';

  final Box<dynamic> _box;

  static Future<LearningProgressLocalDb> open() async {
    final box = await Hive.openBox<dynamic>(boxName);
    return LearningProgressLocalDb(box);
  }

  @override
  Future<LearningProgressSnapshot> load() async {
    final learnedLessons = _box.get(
      _learnedLessonsKey,
      defaultValue: <dynamic>[],
    );
    final earnedBadges = _box.get(_earnedBadgesKey, defaultValue: <dynamic>[]);
    final lessonCompletedAt =
        _box.get(_lessonCompletedAtKey, defaultValue: <String, dynamic>{})
            as Map<dynamic, dynamic>;

    return LearningProgressSnapshot(
      learnedLessonIds: Set<String>.from(learnedLessons as List<dynamic>),
      earnedBadgeIds: Set<String>.from(earnedBadges as List<dynamic>),
      lessonCompletedAt: {
        for (final entry in lessonCompletedAt.entries)
          entry.key as String: DateTime.parse(entry.value as String),
      },
    );
  }

  @override
  Future<void> save({
    required Set<String> learnedLessonIds,
    required Set<String> earnedBadgeIds,
    required Map<String, DateTime> lessonCompletedAt,
  }) async {
    await _box.put(_learnedLessonsKey, learnedLessonIds.toList()..sort());
    await _box.put(_earnedBadgesKey, earnedBadgeIds.toList()..sort());
    await _box.put(_lessonCompletedAtKey, {
      for (final entry in lessonCompletedAt.entries)
        entry.key: entry.value.toIso8601String(),
    });
  }
}
