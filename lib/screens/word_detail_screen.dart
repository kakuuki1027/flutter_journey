import 'package:flutter/material.dart';

import '../data/word_repository.dart';

class WordDetailScreen extends StatelessWidget{
  final WordRepository repo;
  final String wordId;

  const WordDetailScreen({super.key, required this .repo, required this.wordId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Word Detail')),
      body: FutureBuilder(
        future: repo.getWordById(wordId),
        builder: (context, snapshot) {
          if(snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final word = snapshot.data;
          if(word == null) {
            return const Center(child: Text('Words not found.'));
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(word.japanese, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Reading: ${word.reading}', style: TextStyle(fontSize: 16),),
                const SizedBox(height: 8),
                Text('Meaning: ${word.meaning}', style: TextStyle(fontSize: 16),),
                const SizedBox(height: 12),
                if(word.example != null) Text('Example: ${word.example}'),
                const SizedBox(height: 12),
                Text('JLPT: ${word.jlptLevel ?? "-"}'),
                const SizedBox(height: 12),
                Text('Status: ${word.status.name}'),
              ],
            ),
          );
        }
      )
    );
  }
}