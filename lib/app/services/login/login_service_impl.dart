import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolist/app/repositories/login/login_repository.dart';

import './login_service.dart';

class LoginServiceImpl implements LoginService {
  final LoginRepository _loginRepository;
  LoginServiceImpl({
    required LoginRepository loginRepository,
  }) : _loginRepository = loginRepository;

  @override
  Future<UserCredential> login() => _loginRepository.login();

  @override
  Future<void> logout() => _loginRepository.logout();

  @override
  Future<User?> register(String email, String password) =>
      _loginRepository.loginFirebase(email, password);
}
