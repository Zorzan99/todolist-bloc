import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/app/modules/home/register_controller.dart';
import 'package:todolist/app/modules/home/register_page.dart';
import 'package:todolist/app/repositories/register/register_repository.dart';
import 'package:todolist/app/repositories/register/register_repository_impl.dart';

class RegisterRouter {
  RegisterRouter._();
  static Widget get page => MultiProvider(
        providers: [
          Provider<RegisterRepository>(
            create: (context) =>
                RegisterRepositoryImpl(firebaseAuth: context.read()),
          ),
          Provider(
            create: (context) => RegisterRepository,
          ),
          Provider(
            create: (context) => RegisterController(
              context.read(),
            ),
          ),
        ],
        child: const RegisterPage(),
      );
}
