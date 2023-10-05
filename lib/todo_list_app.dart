import 'package:flutter/material.dart';
import 'package:todolist/app/core/ui/theme/theme_config.dart';
import 'package:todolist/app/modules/home/register_page.dart';
import 'package:todolist/app/modules/splash/splash_page.dart';

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoList',
      theme: ThemeConfig.theme,
      routes: {
        '/': (context) => const SplashPage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}
