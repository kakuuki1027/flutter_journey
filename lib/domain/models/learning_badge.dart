import 'package:flutter/material.dart';

class LearningBadge {
  const LearningBadge({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
}
