import 'package:flutter/material.dart';
import 'package:flutter_journey/data/mock/mock_hub_repository.dart';
import 'package:go_router/go_router.dart';

class WebLinksPage extends StatelessWidget {
  const WebLinksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = MockHubRepository();

    return Scaffold(
      appBar: AppBar(title: const Text('Web Links')),
      body: FutureBuilder(
        future: repo.getLinks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final links = snapshot.data ?? [];
          return ListView.builder(
            itemCount: links.length,
            itemBuilder: (_, i) {
              final link = links[i];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.link),
                  title: Text(link.title),
                  subtitle: Text(link.url),
                  onTap: () => context.push(
                    '/webview?title=${Uri.encodeComponent(link.title)}&url=${Uri.encodeComponent(link.url)}',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}