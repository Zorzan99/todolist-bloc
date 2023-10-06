import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolist/app/core/ui/exceptions/exception.dart';
import 'package:todolist/app/repositories/register/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final FirebaseAuth _firebaseAuth;
  RegisterRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;
  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      log('Erro', error: e, stackTrace: s);

      if (e.code == 'emai-already-in-use') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw RepositoryException(
              message: 'E-mail já utilizado, por favor escolha outro e-mail');
        } else {
          throw RepositoryException(
              message:
                  'Você se cadastrou no TodoList pelo Google, por favor utilize ele para efetuar o login');
        }
      } else {
        throw RepositoryException(
            message: e.message ?? 'Erro ao registrar usuário');
      }
    }
  }
}
