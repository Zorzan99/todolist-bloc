import 'package:flutter/material.dart';
import 'package:todolist/app/core/ui/theme/theme_config.dart';
import 'package:todolist/app/modules/home/home_page.dart';
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
        '/home': (context) => const HomePage(),
      },
    );
  }
}
