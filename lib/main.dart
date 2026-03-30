import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_journey/data/local/learning_progress_local_db.dart';
import 'package:flutter_journey/data/mock/mock_auth_repository.dart';
import 'package:flutter_journey/features/auth/auth_controller.dart';
import 'package:flutter_journey/features/learning/learning_catalog.dart';
import 'package:flutter_journey/features/learning/learning_controller.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Hive.initFlutter();
  } else {
    await Hive.initFlutter();
  }

  final authController = AuthController(authRepository: MockAuthRepository());
  final learningDb = await LearningProgressLocalDb.open();
  final lessons = await LearningCatalog.build();
  final learningController = LearningController(
    progressRepository: learningDb,
    lessons: lessons,
  );
  await learningController.load();

  runApp(
    LearnFlutterHubApp(
      authController: authController,
      learningController: learningController,
    ),
  );
}
