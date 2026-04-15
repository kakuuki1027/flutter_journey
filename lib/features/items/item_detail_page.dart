import 'package:flutter/material.dart';
import 'package:flutter_journey/features/items/item_lesson_content.dart';
import 'package:flutter_journey/features/learning/learning_controller.dart';
import 'package:flutter_journey/features/learning/widgets/badge_celebration_dialog.dart';
import 'package:provider/provider.dart';

class ItemDetailPage extends StatelessWidget {
  const ItemDetailPage({required this.itemId, super.key});

  final String itemId;

  @override
  Widget build(BuildContext context) {
    final content = repositoryLessonContentById[itemId];
    final learningController = context.watch<LearningController>();
    final isLearned = learningController.isLessonLearned(itemId);

    if (content == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('学習内容')),
        body: const Center(child: Text('学習コンテンツが見つかりません。')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(content.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'このレッスンで学ぶこと',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(content.overview),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '要点',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (final point in content.keyPoints)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: Icon(Icons.check_circle, size: 18),
                          ),
                          const SizedBox(width: 10),
                          Expanded(child: Text(point)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'コード例',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF111827),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SelectableText(
                      content.exampleCode,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '学習チェック',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (final item in content.practiceChecklist)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: Icon(Icons.radio_button_checked, size: 18),
                          ),
                          const SizedBox(width: 10),
                          Expanded(child: Text(item)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: isLearned
                ? null
                : () async {
                    final badges = await context
                        .read<LearningController>()
                        .markLessonLearned(itemId);

                    if (!context.mounted || badges.isEmpty) {
                      return;
                    }

                    await showBadgeCelebrationDialog(context, badges);
                  },
            icon: Icon(
              isLearned ? Icons.workspace_premium : Icons.check_circle,
            ),
            label: Text(isLearned ? 'この内容は学習完了済みです' : 'この内容を学習完了にする'),
          ),
        ],
      ),
    );
  }
}
