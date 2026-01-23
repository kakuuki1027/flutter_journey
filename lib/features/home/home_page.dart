import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  Widget _tile(BuildContext context, {required String title, required String subtitle, required String route}) {
    return Card(
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600),),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(route),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LearnFlutter Hub')),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Pick a module',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          _tile(context, title: 'Videos', subtitle: 'Play Youtube videos', route: '/videos'),
          _tile(context, title: 'Web', subtitle: 'Open internet pages in-app', route: '/web'),
          _tile(context, title: 'Repository Items', subtitle: 'Mock data + clean separation', route: '/items'),
        ],
      ),
    );
  }
}