import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_journey/domain/models/learning_badge.dart';

Future<void> showBadgeCelebrationDialog(
  BuildContext context,
  List<LearningBadge> badges,
) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (_) => _BadgeCelebrationDialog(badges: badges),
  );
}

class _BadgeCelebrationDialog extends StatefulWidget {
  const _BadgeCelebrationDialog({required this.badges});

  final List<LearningBadge> badges;

  @override
  State<_BadgeCelebrationDialog> createState() =>
      _BadgeCelebrationDialogState();
}

class _BadgeCelebrationDialogState extends State<_BadgeCelebrationDialog> {
  late final ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    )..play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.badges.length == 1 ? 'バッジ獲得' : 'バッジを獲得しました',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                for (final badge in widget.badges)
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F7FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xFFDCE8FF),
                          child: Icon(badge.icon, color: Colors.indigo),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                badge.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(badge.description),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('学習を続ける'),
                ),
              ],
            ),
          ),
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: pi / 2,
            emissionFrequency: 0.08,
            numberOfParticles: 18,
            gravity: 0.2,
            shouldLoop: false,
            colors: const [
              Color(0xFF5E60CE),
              Color(0xFF4EA8DE),
              Color(0xFFFFB703),
              Color(0xFFFB8500),
              Color(0xFF52B788),
            ],
          ),
        ],
      ),
    );
  }
}
