
import 'package:flutter/material.dart';

import '../models/word.dart';

class WordbookStore extends ChangeNotifier {
  final List<Word> _word = [];

  List<Word> get words => List.unmodifiable(_word);
}