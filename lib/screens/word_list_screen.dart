import 'package:flutter/material.dart';

import '../app/routes.dart';
import '../data/word_repository.dart';
import '../models/word.dart';

class WordListScreen extends StatelessWidget{
  final WordRepository repo;

  const WordListScreen({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My words')),
      body: FutureBuilder<List<Word>>(
        future: repo.getWords(),
        builder: (context, snapshot) {
          if(snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final words = snapshot.data ?? const <Word>[];
          if(words.isEmpty) {
            return const Center(child: Text('no words yet.'));
          }
          return ListView.separated(
            itemCount: words.length,
            separatorBuilder: (_, __) => const Divider(height: 1,),
            itemBuilder: (context, i) {
              final w = words[i];
              return ListTile(
                title: Text(w.japanese),
                subtitle: Text('${w.reading}  ${w.meaning}'),
                trailing: Text(w.jlptLevel ?? ''),
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.wordDetail,
                  arguments: w.id
                ),
              );
            }
          );
        }
      )
    );
  }
}