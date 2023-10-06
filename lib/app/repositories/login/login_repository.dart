import 'package:firebase_auth/firebase_auth.dart';

abstract interface class LoginRepository {
  Future<UserCredential> login();
  Future<User?> loginFirebase(String email, String password);

  Future<void> logout();
}
