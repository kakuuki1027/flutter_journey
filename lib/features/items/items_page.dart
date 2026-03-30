import 'package:flutter/material.dart';
import 'package:flutter_journey/data/mock/mock_hub_repository.dart';
import 'package:flutter_journey/features/common/searchable_lesson_list_scaffold.dart';
import 'package:flutter_journey/features/learning/learning_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = MockHubRepository();
    final learningController = context.watch<LearningController>();

    return SearchableLessonListScaffold(
      title: 'リポジトリ学習',
      loader: repo.getItems,
      filterText: (item) => '${item.title} ${item.subtitle}',
      emptyTitle: '一致する項目がありません',
      emptySubtitle: '別のキーワードで検索してください。',
      itemBuilder: (context, item) => Card(
        child: ListTile(
          title: Text(
            item.title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            [
              item.subtitle,
              learningController.completedAtLabel(item.id),
            ].whereType<String>().join(' • '),
          ),
          onTap: () => context.push('/items/${item.id}'),
          trailing: learningController.isLessonLearned(item.id)
              ? const Icon(Icons.workspace_premium, color: Colors.amber)
              : const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
