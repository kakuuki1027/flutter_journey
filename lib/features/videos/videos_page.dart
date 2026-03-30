import 'package:flutter/material.dart';
import 'package:flutter_journey/data/mock/mock_hub_repository.dart';
import 'package:flutter_journey/features/common/searchable_lesson_list_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../learning/learning_controller.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = MockHubRepository();
    final learningController = context.watch<LearningController>();

    return SearchableLessonListScaffold(
      title: '学習動画',
      loader: repo.getVideos,
      filterText: (video) => '${video.title} ${video.description}',
      emptyTitle: '一致する動画がありません',
      emptySubtitle: '動画タイトルやトピックで検索してください。',
      itemBuilder: (context, video) => Card(
        child: ListTile(
          leading: const Icon(Icons.play_circle_outline),
          title: Text(video.title),
          subtitle: Text(
            [
              video.description,
              learningController.completedAtLabel(video.id),
            ].whereType<String>().join(' • '),
          ),
          trailing: learningController.isLessonLearned(video.id)
              ? const Icon(Icons.workspace_premium, color: Colors.amber)
              : null,
          onTap: () {
            context.push(
              '/videos/${Uri.encodeComponent(video.youtubeId)}?title=${Uri.encodeComponent(video.title)}&lessonId=${Uri.encodeComponent(video.id)}',
            );
          },
        ),
      ),
    );
  }
}
