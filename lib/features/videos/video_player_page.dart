import 'package:flutter/material.dart';
import 'package:flutter_journey/features/learning/learning_controller.dart';
import 'package:flutter_journey/features/learning/widgets/badge_celebration_dialog.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  final String youtubeId;
  final String title;
  final String lessonId;

  const VideoPlayerPage({
    super.key,
    required this.youtubeId,
    required this.title,
    required this.lessonId,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final learningController = context.watch<LearningController>();
    final isLearned = learningController.isLessonLearned(widget.lessonId);

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'YouTube ID: ${widget.youtubeId}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: isLearned
                  ? null
                  : () async {
                      final badges = await context
                          .read<LearningController>()
                          .markLessonLearned(widget.lessonId);

                      if (!context.mounted || badges.isEmpty) {
                        return;
                      }

                      await showBadgeCelebrationDialog(context, badges);
                    },
              icon: Icon(isLearned ? Icons.workspace_premium : Icons.check),
              label: Text(isLearned ? 'この動画のバッジを獲得済み' : 'この動画を学習完了にする'),
            ),
          ],
        ),
      ),
    );
  }
}
