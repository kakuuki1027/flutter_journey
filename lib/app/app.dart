import 'package:flutter/material.dart';
import 'package:flutter_journey/app/routes.dart';
import 'package:flutter_journey/app/theme.dart';
import 'package:flutter_journey/features/auth/auth_controller.dart';
import 'package:flutter_journey/features/learning/learning_controller.dart';
import 'package:provider/provider.dart';

class LearnFlutterHubApp extends StatelessWidget {
  const LearnFlutterHubApp({
    required this.authController,
    required this.learningController,
    super.key,
  });

  final AuthController authController;
  final LearningController learningController;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>.value(value: authController),
        ChangeNotifierProvider<LearningController>.value(
          value: learningController,
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter 学習ハブ',
        theme: AppTheme.light(),
        routerConfig: createRouter(authController),
      ),
    );
  }
}
