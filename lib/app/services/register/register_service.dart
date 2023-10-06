import 'package:firebase_auth/firebase_auth.dart';

abstract interface class RegisterService {
  Future<User?> register(String email, String password);
}
