import 'package:flutter/material.dart';
import 'package:flutter_journey/features/learning/learning_controller.dart';
import 'package:flutter_journey/features/learning/widgets/badge_celebration_dialog.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;
  final String lessonId;

  const WebViewPage({
    super.key,
    required this.url,
    required this.title,
    required this.lessonId,
  });

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;
  int _progress = 0;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(onProgress: (p) => setState(() => _progress = p)),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    final learningController = context.watch<LearningController>();
    final isLearned = learningController.isLessonLearned(widget.lessonId);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            tooltip: '再読み込み',
            icon: const Icon(Icons.refresh),
            onPressed: () => _controller.reload(),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: _progress < 100
              ? LinearProgressIndicator(value: _progress / 100)
              : const SizedBox(height: 3),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: WebViewWidget(controller: _controller)),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: isLearned
                      ? null
                      : () async {
                          final badges = await context
                              .read<LearningController>()
                              .markLessonLearned(widget.lessonId);

                          if (!context.mounted || badges.isEmpty) {
                            return;
                          }

                          await showBadgeCelebrationDialog(context, badges);
                        },
                  icon: Icon(
                    isLearned ? Icons.workspace_premium : Icons.check_circle,
                  ),
                  label: Text(isLearned ? 'この教材のバッジを獲得済み' : 'この教材を学習完了にする'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
