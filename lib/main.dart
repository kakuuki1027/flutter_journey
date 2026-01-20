import 'package:flutter/material.dart';

import 'app/app.dart';
import 'data/in_memory_word_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(WordbookApp(repo: InMemoryWordRepository()));
}