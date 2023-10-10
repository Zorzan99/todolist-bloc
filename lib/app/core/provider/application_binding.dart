// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/app/repositories/login/login_repository.dart';
import 'package:todolist/app/repositories/login/login_repository_impl.dart';
import 'package:todolist/app/repositories/register/register_repository.dart';
import 'package:todolist/app/repositories/register/register_repository_impl.dart';

class ApplicationBinding extends StatelessWidget {
  final Widget child;

  const ApplicationBinding({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginRepository>(
          create: (context) => LoginRepositoryImpl(
            firebaseAuth: context.read(),
          ),
        ),
        Provider<RegisterRepository>(
          create: (context) => RegisterRepositoryImpl(
            firebaseAuth: context.read(),
          ),
        ),
      ],
      child: child,
    );
  }
}
