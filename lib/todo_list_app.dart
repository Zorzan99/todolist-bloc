import 'package:flutter/material.dart';
import 'package:todolist/app/core/ui/theme/theme_config.dart';
import 'package:todolist/app/modules/home/home_router.dart';
import 'package:todolist/app/modules/login/login_router.dart';
import 'package:todolist/app/modules/register/register_router.dart';

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoList',
      theme: ThemeConfig.theme,
      routes: {
        '/': (context) => LoginRouter.page,
        '/register': (context) => RegisterRouter.page,
        '/home': (context) => HomeRouter.page,
      },
    );
  }
}
