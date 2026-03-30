import 'package:flutter/material.dart';
import 'package:flutter_journey/features/learning/learning_controller.dart';
import 'package:provider/provider.dart';

class BadgesPage extends StatelessWidget {
  const BadgesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final learningController = context.watch<LearningController>();
    final badges = learningController.earnedBadges;

    return Scaffold(
      appBar: AppBar(title: const Text('バッジ一覧')),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFF7C948), Color(0xFFFFD978)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '獲得したバッジ',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF4B3200),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${badges.length} 個のバッジを獲得済みです',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFF6E4A00),
                  ),
                ),
              ],
            ),
          ),
          if (badges.isEmpty)
            const Card(
              child: ListTile(
                leading: Icon(Icons.military_tech_outlined),
                title: Text('まだバッジはありません'),
                subtitle: Text('レッスンを完了するとここにバッジが表示されます。'),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final badge in badges)
                    _BadgeCard(
                      title: badge.title,
                      description: badge.description,
                      icon: badge.icon,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFE8EEFF),
            child: Icon(icon, color: const Color(0xFF395BDF)),
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(description, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
