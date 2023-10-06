import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/app/modules/home/register_controller.dart';
import 'package:todolist/app/modules/home/register_page.dart';

class RegisterRouter {
  RegisterRouter._();
  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => RegisterController(
              context.read(),
            ),
          ),
        ],
        child: const RegisterPage(),
      );
}
