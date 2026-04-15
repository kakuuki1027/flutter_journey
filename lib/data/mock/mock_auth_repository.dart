import 'package:flutter_journey/domain/models/auth_session.dart';
import 'package:flutter_journey/domain/repositories/auth_repository.dart';

class MockAuthException implements Exception {
  const MockAuthException(this.message);

  final String message;

  @override
  String toString() => message;
}

class MockAuthRepository implements AuthRepository {
  static const demoEmail = 'demo@flutter.dev';
  static const demoPassword = 'password123';

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 700));

    if (email.trim().toLowerCase() != demoEmail || password != demoPassword) {
      throw const MockAuthException(
        '認証に失敗しました。demo@flutter.dev / password123 を使ってください。',
      );
    }

    return const AuthSession(
      email: demoEmail,
      displayName: 'Flutter太郎',
      token: 'local-mock-token',
    );
  }
}
