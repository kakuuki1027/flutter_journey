enum WordStatus { newWord, learning, mastered }

class Word {
  final String id;
  final String japanese;
  final String reading;
  final String meaning;
  final String? example;
  final String? jlptLevel;
  final WordStatus status;
  
  const Word({
    required this.id,
    required this.japanese,
    required this.reading,
    required this.meaning,
    this.example,
    this.jlptLevel,
    this.status = WordStatus.newWord,
  });

  Word copyWith({
    String? id,
    String? japanese,
    String? reading,
    String? meaning,
    String? example,
    String? jlptLevel,
    WordStatus? status,
  }) {
    return Word(
      id: id ?? this.id,
      japanese: japanese ?? this.japanese,
      reading: reading ?? this.reading,
      meaning: meaning ?? this.meaning,
      example: example ?? this.example,
      jlptLevel: jlptLevel ?? this.jlptLevel,
      status: status ?? this.status,
    );
  }
}



