import 'package:flutter_journey/domain/models/auth_session.dart';

abstract class AuthRepository {
  Future<AuthSession> login({required String email, required String password});
}
