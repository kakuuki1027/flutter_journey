import 'package:flutter/material.dart';
import 'package:flutter_journey/data/mock/mock_hub_repository.dart';
import 'package:flutter_journey/features/common/searchable_lesson_list_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../learning/learning_controller.dart';

class WebLinksPage extends StatelessWidget {
  const WebLinksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = MockHubRepository();
    final learningController = context.watch<LearningController>();

    return SearchableLessonListScaffold(
      title: 'ウェブ教材',
      loader: repo.getLinks,
      filterText: (link) => '${link.title} ${link.url}',
      emptyTitle: '一致するウェブ教材がありません',
      emptySubtitle: 'タイトルや URL で検索してください。',
      itemBuilder: (context, link) => Card(
        child: ListTile(
          leading: const Icon(Icons.link),
          title: Text(link.title),
          subtitle: Text(
            [
              link.url,
              learningController.completedAtLabel(link.id),
            ].whereType<String>().join(' • '),
          ),
          trailing: learningController.isLessonLearned(link.id)
              ? const Icon(Icons.workspace_premium, color: Colors.amber)
              : null,
          onTap: () => context.push(
            '/webview?title=${Uri.encodeComponent(link.title)}&url=${Uri.encodeComponent(link.url)}&lessonId=${Uri.encodeComponent(link.id)}',
          ),
        ),
      ),
    );
  }
}
