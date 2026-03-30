import 'package:flutter/material.dart';
import 'package:flutter_journey/domain/models/learning_badge.dart';
import 'package:flutter_journey/domain/models/learning_lesson.dart';
import 'package:flutter_journey/domain/repositories/learning_progress_repository.dart';

class LearningController extends ChangeNotifier {
  LearningController({
    required LearningProgressRepository progressRepository,
    required List<LearningLesson> lessons,
    DateTime Function()? now,
  }) : _progressRepository = progressRepository,
       _lessons = {for (final lesson in lessons) lesson.id: lesson},
       _now = now ?? DateTime.now;

  static const completionBadgeId = 'all_lessons_completed';

  final LearningProgressRepository _progressRepository;
  final Map<String, LearningLesson> _lessons;
  final DateTime Function() _now;

  final Set<String> _learnedLessonIds = <String>{};
  final Set<String> _earnedBadgeIds = <String>{};
  final Map<String, DateTime> _lessonCompletedAt = <String, DateTime>{};

  bool _isReady = false;

  bool get isReady => _isReady;
  int get totalLessons => _lessons.length;
  int get learnedLessonsCount => _learnedLessonIds.length;
  bool get hasCompletedAllLessons =>
      totalLessons > 0 && learnedLessonsCount == totalLessons;

  double get progress =>
      totalLessons == 0 ? 0 : learnedLessonsCount / totalLessons;

  List<LearningLesson> get lessons => _lessons.values.toList();
  List<LearningLesson> get nextLessons => _lessons.values
      .where((lesson) => !_learnedLessonIds.contains(lesson.id))
      .take(3)
      .toList();

  List<LearningLesson> get recentLessons {
    final entries = _lessonCompletedAt.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return entries
        .map((entry) => _lessons[entry.key])
        .whereType<LearningLesson>()
        .take(3)
        .toList();
  }

  String? completedAtLabel(String lessonId) {
    final completedAt = _lessonCompletedAt[lessonId];
    if (completedAt == null) {
      return null;
    }

    final now = _now();
    final today = DateTime(now.year, now.month, now.day);
    final completedDay = DateTime(
      completedAt.year,
      completedAt.month,
      completedAt.day,
    );
    final diff = today.difference(completedDay).inDays;

    if (diff <= 0) {
      return '今日完了';
    }
    if (diff == 1) {
      return '昨日完了';
    }
    return '${completedAt.year}/${completedAt.month}/${completedAt.day} に完了';
  }

  int get currentStreakDays {
    if (_lessonCompletedAt.isEmpty) {
      return 0;
    }

    final uniqueDays =
        _lessonCompletedAt.values
            .map((date) => DateTime(date.year, date.month, date.day))
            .toSet()
            .toList()
          ..sort((a, b) => b.compareTo(a));

    final today = _dateOnly(_now());
    final latestDay = uniqueDays.first;
    final daysSinceLatest = today.difference(latestDay).inDays;

    if (daysSinceLatest > 1) {
      return 0;
    }

    var streak = 1;
    var expected = latestDay;

    for (var i = 1; i < uniqueDays.length; i++) {
      expected = expected.subtract(const Duration(days: 1));
      if (uniqueDays[i] == expected) {
        streak++;
      } else {
        break;
      }
    }

    return streak;
  }

  DateTime? get lastLearnedAt {
    if (_lessonCompletedAt.isEmpty) {
      return null;
    }

    return _lessonCompletedAt.values.reduce(
      (current, next) => current.isAfter(next) ? current : next,
    );
  }

  List<LearningBadge> get earnedBadges =>
      _earnedBadgeIds.map(_badgeForId).whereType<LearningBadge>().toList();

  Future<void> load() async {
    final snapshot = await _progressRepository.load();
    _learnedLessonIds
      ..clear()
      ..addAll(snapshot.learnedLessonIds.where(_lessons.containsKey));
    _earnedBadgeIds
      ..clear()
      ..addAll(snapshot.earnedBadgeIds);
    _lessonCompletedAt
      ..clear()
      ..addAll(snapshot.lessonCompletedAt);
    _syncCompletionBadge();
    _isReady = true;
    notifyListeners();
  }

  bool isLessonLearned(String lessonId) => _learnedLessonIds.contains(lessonId);

  LearningBadge badgeForLesson(String lessonId) => LearningBadge(
    id: lessonId,
    title: '${_lessons[lessonId]?.title ?? 'レッスン'} バッジ',
    description: '${_lessons[lessonId]?.title ?? 'レッスン'} を学習完了したので獲得。',
    icon: _iconForCategory(_lessons[lessonId]?.category),
  );

  Future<List<LearningBadge>> markLessonLearned(String lessonId) async {
    final lesson = _lessons[lessonId];

    if (lesson == null || _learnedLessonIds.contains(lessonId)) {
      return const [];
    }

    _learnedLessonIds.add(lessonId);
    _lessonCompletedAt[lessonId] = _now();
    final newlyEarnedBadges = <LearningBadge>[badgeForLesson(lessonId)];
    _earnedBadgeIds.add(lessonId);

    if (_syncCompletionBadge()) {
      newlyEarnedBadges.add(_badgeForId(completionBadgeId)!);
    }

    await _persist();
    notifyListeners();
    return newlyEarnedBadges;
  }

  Future<void> resetProgress() async {
    _learnedLessonIds.clear();
    _earnedBadgeIds.clear();
    _lessonCompletedAt.clear();
    await _persist();
    notifyListeners();
  }

  bool _syncCompletionBadge() {
    if (!hasCompletedAllLessons) {
      _earnedBadgeIds.remove(completionBadgeId);
      return false;
    }

    return _earnedBadgeIds.add(completionBadgeId);
  }

  Future<void> _persist() {
    return _progressRepository.save(
      learnedLessonIds: _learnedLessonIds,
      earnedBadgeIds: _earnedBadgeIds,
      lessonCompletedAt: _lessonCompletedAt,
    );
  }

  DateTime _dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  LearningBadge? _badgeForId(String badgeId) {
    if (badgeId == completionBadgeId) {
      return const LearningBadge(
        id: completionBadgeId,
        title: 'Flutter 学習コンプリート',
        description: 'アプリ内のすべてのレッスンを完了すると獲得。',
        icon: Icons.workspace_premium,
      );
    }

    if (!_lessons.containsKey(badgeId)) {
      return null;
    }

    return badgeForLesson(badgeId);
  }

  IconData _iconForCategory(String? category) {
    switch (category) {
      case '動画':
        return Icons.ondemand_video;
      case 'ウェブ':
        return Icons.language;
      case 'リポジトリ':
      default:
        return Icons.school;
    }
  }
}
