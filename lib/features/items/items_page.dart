import 'package:flutter/material.dart';
import 'package:flutter_journey/data/mock/mock_hub_repository.dart';

class ItemsPage extends StatelessWidget{
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = MockHubRepository();

    return Scaffold(
      appBar: AppBar(title: const Text('Repository Items'),),
      body: FutureBuilder(
        future: repo.getItems(),
        builder: (context, snapshot) {
          if(snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator(),);
          }
          final items = snapshot.data ?? [];
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, i) {
              final item = items[i];
              return Card(
                child: ListTile(
                  title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600),),
                  subtitle: Text(item.subtitle),
                ),
              );
            }
          );
        }
      ),
    );
  }
}