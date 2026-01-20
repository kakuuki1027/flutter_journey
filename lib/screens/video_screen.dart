import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoScreen extends StatefulWidget{
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final _controller = YoutubePlayerController(
    params: const YoutubePlayerParams(
      showControls: true,
      showFullscreenButton: true,
      mute:false,
    ),
  );

  final _textController = TextEditingController(text: 'dQw4w9WgXcQ');

  @override
  void dispose() {
    _controller.close();
    _textController.dispose();
    super.dispose();
  }

  void _load() {
    final input = _textController.text.trim();
    final id = _extractVideoId(input) ?? input;
    _controller.loadVideoById(videoId: id);
  }

  String ? _extractVideoId(String input) {
    final uri = Uri.tryParse(input);
    if(uri == null) return null;

    if(uri.host.contains('youtube.be')) {
      final seg = uri.pathSegments;
      return seg.isNotEmpty ? seg.first : null;
    }
    if(uri.host.contains('youtube.com')) {
      return uri.queryParameters['v'];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'YouTube URL or Video ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _load,
                    child: const Text('Load'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: YoutubePlayer(
                controller: _controller,
                aspectRatio: 16 / 9,
              )
            )
          ],
        ),
      ),
    );
  }
}