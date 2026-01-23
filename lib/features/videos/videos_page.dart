import 'package:flutter/material.dart';
import 'package:flutter_journey/data/mock/mock_hub_repository.dart';
import 'package:go_router/go_router.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = MockHubRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Videos'),
      ),
      body: FutureBuilder(
        future: repo.getVideos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final videos = snapshot.data ?? [];

          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (_, i) {
              final v = videos[i];

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.play_circle_outline),
                  title: Text(v.title),
                  subtitle: Text(v.description),
                  onTap: () {
                    context.push('/videos/${Uri.encodeComponent(v.youtubeId)}?title=${Uri.encodeComponent(v.title)}');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}