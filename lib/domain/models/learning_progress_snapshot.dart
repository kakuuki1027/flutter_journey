class LearningProgressSnapshot {
  const LearningProgressSnapshot({
    required this.learnedLessonIds,
    required this.earnedBadgeIds,
    required this.lessonCompletedAt,
  });

  final Set<String> learnedLessonIds;
  final Set<String> earnedBadgeIds;
  final Map<String, DateTime> lessonCompletedAt;
}
