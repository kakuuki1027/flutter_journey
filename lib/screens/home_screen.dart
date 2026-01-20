import 'package:flutter/material.dart';

import '../app/routes.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Japanese Wordbook'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Local demo app (mock data).', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.words),
            child: const Text('My words'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.review),
            child: const Text('Review'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.video),
            child: const Text('Video'),
          ),
        ],
      ),
    );
  }
}