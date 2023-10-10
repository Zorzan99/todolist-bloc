import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/app/modules/login/login_controller.dart';
import 'package:todolist/app/modules/login/login_page.dart';
import 'package:todolist/app/repositories/login/login_repository.dart';
import 'package:todolist/app/repositories/login/login_repository_impl.dart';

class LoginRouter {
  LoginRouter._();
  static Widget get page => MultiProvider(
        providers: [
          Provider<LoginRepository>(
            create: (context) => LoginRepositoryImpl(
              firebaseAuth: context.read(),
            ),
          ),
          Provider(
            create: (context) => LoginRepository,
          ),
          Provider(
            create: (context) => LoginController(
              context.read(),
            ),
          )
        ],
        child: const LoginPage(),
      );
}
