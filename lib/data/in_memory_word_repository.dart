import '../models/word.dart';
import 'word_repository.dart';

class InMemoryWordRepository implements WordRepository{
  final List<Word> _words = const [
    Word(
      id: '1',
      japanese: '食べる',
      reading: 'たべる',
      meaning: 'to eat',
      example: '毎日りんごを食べる。',
      jlptLevel: 'N5',
      status: WordStatus.learning,
    ),
    Word(
      id: '2',
      japanese: '勉強',
      reading: 'べんきょう',
      meaning: 'study',
      example: '日本語を勉強しています。',
      jlptLevel: 'N5',
      status: WordStatus.newWord,
    ),
    Word(
      id: '3',
      japanese: '大丈夫',
      reading: 'だいじょうぶ',
      meaning: 'okay / all right',
      example: '大丈夫です。',
      jlptLevel: 'N5',
      status: WordStatus.mastered,
    ),
  ];

  @override
  Future<List<Word>> getWords() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return List<Word>.unmodifiable(_words);
  }

  @override
  Future<Word?> getWordById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    try {
      return _words.firstWhere((w) => w.id == id);
    } catch (_) {
      return null;
    }
  }
}