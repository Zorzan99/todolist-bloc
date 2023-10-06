import 'package:firebase_auth/firebase_auth.dart';

abstract interface class LoginService {
  Future<UserCredential> login();
  Future<User?> register(String email, String password);

  Future<void> logout();
}
