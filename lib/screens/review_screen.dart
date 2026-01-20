import 'package:flutter/material.dart';
import 'package:flutter_journey/data/word_repository.dart';
import 'package:flutter_journey/models/word.dart';

class ReviewScreen extends StatefulWidget{
  final WordRepository repo;
  const ReviewScreen({super.key, required this.repo});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int _index = 0;
  bool _showBack = false;
  List<Word> _words = const [];

  @override
  void initState() {
    super.initState();
    widget.repo.getWords().then((list) {
      final sorted = [...list]..sort((a, b) {
        int rank(WordStatus s) => switch (s) {
          WordStatus.newWord => 0,
          WordStatus.learning => 1,
          WordStatus.mastered => 2,
        };
        return rank(a.status).compareTo(rank(b.status));
      });
      setState(() => _words = sorted);
    });
  }

  void _next() {
    if(_words.isEmpty) return;
    setState(() {
      _showBack = false;
      _index = (_index + 1) % _words.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasData = _words.isNotEmpty;
    final current = hasData ? _words[_index] : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Review')),
      body: hasData
        ? Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => setState(() => 
                    _showBack = !_showBack
                  ),
                  child: Card(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          _showBack ? '${current!.reading}\n\n${current.meaning}'
                            : current!.japanese,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                  ),
                )
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: _next, child: const Text('Again')),
                  ElevatedButton(onPressed: _next, child: const Text('Good')),
                  ElevatedButton(onPressed: _next, child: const Text('Easy')),
                ],
              )
            ],
          ),
      )
      : const Center(child: CircularProgressIndicator()),
    );
  }
}