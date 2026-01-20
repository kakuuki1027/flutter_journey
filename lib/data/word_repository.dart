import '../models/word.dart';

abstract class WordRepository {
  Future<List<Word>> getWords();
  Future<Word?> getWordById(String id);
}