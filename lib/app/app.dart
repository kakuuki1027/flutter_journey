import 'package:flutter/material.dart';
import 'package:flutter_journey/app/routes.dart';
import 'package:flutter_journey/app/theme.dart';

class LearnFlutterHubApp extends StatelessWidget {
  const LearnFlutterHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LearnFlutter Hub',
      theme: AppTheme.light(),
      routerConfig: router,
    );
  }
 }