import 'package:flutter/material.dart';
import 'package:flutter_journey/features/auth/auth_controller.dart';
import 'package:flutter_journey/features/learning/learning_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _categoryRoutes = <String, String>{
    'リポジトリ': '/items',
    '動画': '/videos',
    'ウェブ': '/web',
  };

  Widget _tile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String route,
  }) {
    return Card(
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(route),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    final learningController = context.watch<LearningController>();
    final signedInAs =
        authController.session?.displayName ??
        authController.session?.email ??
        '';
    final earnedBadges = learningController.earnedBadges;
    final nextLessons = learningController.nextLessons;
    final recentLessons = learningController.recentLessons;

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter 学習ハブ')),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DrawerHeader(
                margin: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Flutter太郎',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      signedInAs,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('ホーム'),
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                leading: const Icon(Icons.workspace_premium_outlined),
                title: const Text('バッジ一覧'),
                onTap: () {
                  Navigator.of(context).pop();
                  context.push('/badges');
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('ログアウト'),
                onTap: () {
                  Navigator.of(context).pop();
                  authController.logout();
                  context.go('/login');
                },
              ),
              ListTile(
                leading: const Icon(Icons.restart_alt),
                title: const Text('学習履歴をリセット'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await learningController.resetProgress();
                },
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF395BDF), Color(0xFF6C8CFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'おかえりなさい、$signedInAs さん',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${learningController.totalLessons} レッスン中 ${learningController.learnedLessonsCount} 件を完了',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: learningController.progress,
                    minHeight: 12,
                    backgroundColor: Colors.white24,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFFFFD166),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _summaryChip(
                      context,
                      icon: Icons.local_fire_department,
                      label: '${learningController.currentStreakDays}日連続',
                    ),
                    _summaryChip(
                      context,
                      icon: Icons.workspace_premium,
                      label: 'バッジ ${earnedBadges.length}個',
                    ),
                    _summaryChip(
                      context,
                      icon: Icons.emoji_events,
                      label: learningController.hasCompletedAllLessons
                          ? '全学習を達成'
                          : '学習継続中',
                    ),
                  ],
                ),
                if (learningController.lastLearnedAt != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    '最終学習: ${learningController.completedAtLabel(recentLessons.isNotEmpty ? recentLessons.first.id : '') ?? 'まだ記録がありません'}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              '学習メニュー',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          _tile(
            context,
            title: 'リポジトリ学習',
            subtitle: 'Flutter の基本概念を項目ごとに確認',
            route: '/items',
          ),
          _tile(
            context,
            title: '学習動画',
            subtitle: 'Flutter 学習向け動画を見る',
            route: '/videos',
          ),
          _tile(
            context,
            title: 'ウェブ教材',
            subtitle: '公式ドキュメントや教材をアプリ内で読む',
            route: '/web',
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              '次に学ぶ内容',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          if (nextLessons.isEmpty)
            const Card(
              child: ListTile(
                leading: Icon(Icons.celebration_outlined),
                title: Text('すべて完了しています'),
                subtitle: Text('アプリ内のすべてのレッスンを完了しました。'),
              ),
            )
          else
            ...nextLessons.map(
              (lesson) => Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFE8EEFF),
                    child: Icon(
                      _iconForCategory(lesson.category),
                      color: const Color(0xFF395BDF),
                    ),
                  ),
                  title: Text(lesson.title),
                  subtitle: Text('${lesson.category}の学習を続けましょう'),
                  trailing: FilledButton.tonal(
                    onPressed: () => context.push(
                      _categoryRoutes[lesson.category] ?? '/items',
                    ),
                    child: const Text('開く'),
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              '最近の学習履歴',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          if (recentLessons.isEmpty)
            const Card(
              child: ListTile(
                leading: Icon(Icons.history_outlined),
                title: Text('最近の履歴はありません'),
                subtitle: Text('レッスンを完了すると履歴が表示されます。'),
              ),
            )
          else
            ...recentLessons.map(
              (lesson) => Card(
                child: ListTile(
                  leading: Icon(_iconForCategory(lesson.category)),
                  title: Text(lesson.title),
                  subtitle: Text(
                    learningController.completedAtLabel(lesson.id) ?? '最近完了',
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _summaryChip(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  IconData _iconForCategory(String category) {
    switch (category) {
      case '動画':
        return Icons.ondemand_video;
      case 'ウェブ':
        return Icons.language;
      case 'リポジトリ':
      default:
        return Icons.school;
    }
  }
}
