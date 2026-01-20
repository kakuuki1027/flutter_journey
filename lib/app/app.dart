import 'package:flutter/material.dart';
import 'package:flutter_journey/app/routes.dart';
import 'package:flutter_journey/data/word_repository.dart';
import 'package:flutter_journey/screens/home_screen.dart';
import 'package:flutter_journey/screens/review_screen.dart';
import 'package:flutter_journey/screens/video_screen.dart';
import 'package:flutter_journey/screens/word_detail_screen.dart';
import 'package:flutter_journey/screens/word_list_screen.dart';

class WordbookApp extends StatelessWidget {
  final WordRepository repo;

  const WordbookApp({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Japanese Wordbook',
      theme: ThemeData(useMaterial3: true),
      initialRoute: Routes.home,
      routes: {
        Routes.home: (_) => HomeScreen(),
        Routes.words: (_) => WordListScreen(repo: repo),
        Routes.review: (_) => ReviewScreen(repo: repo),
        Routes.video: (_) => const VideoScreen(),
      },
      onGenerateRoute: (settings) {
        if(settings.name == Routes.wordDetail) {
          final id = settings.arguments as String;
          return MaterialPageRoute(
            builder: (_) => WordDetailScreen(repo: repo, wordId: id),
          );
        }
        return null;
      },
    );
  }
}