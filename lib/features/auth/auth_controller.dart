import 'package:flutter/foundation.dart';
import 'package:flutter_journey/domain/models/auth_session.dart';
import 'package:flutter_journey/domain/repositories/auth_repository.dart';
import 'package:flutter_journey/data/mock/mock_auth_repository.dart';

class AuthController extends ChangeNotifier {
  AuthController({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  AuthSession? _session;
  bool _isLoading = false;
  String? _errorMessage;

  AuthSession? get session => _session;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _session != null;

  String get demoEmail => MockAuthRepository.demoEmail;
  String get demoPassword => MockAuthRepository.demoPassword;

  Future<bool> login({required String email, required String password}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _session = await _authRepository.login(email: email, password: password);
      return true;
    } on MockAuthException catch (error) {
      _errorMessage = error.message;
      return false;
    } catch (_) {
      _errorMessage = 'ログイン中に問題が発生しました。';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _session = null;
    _errorMessage = null;
    notifyListeners();
  }
}
