import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todolist/app/core/auth/auth_service.dart';
import 'package:todolist/app/modules/home/home_controller.dart';
import 'package:todolist/app/modules/home/home_page.dart';
import 'package:todolist/app/repositories/home/home_repository.dart';
import 'package:todolist/app/repositories/home/home_repository_impl.dart';

class HomeRouter {
  HomeRouter._();
  static Widget get page => MultiProvider(
        providers: [
          Provider<HomeRepository>(
            create: (context) => HomeRepositoryImpl(),
          ),
          Provider(
            create: (context) => HomeRepository,
          ),
          Provider(
            create: (context) => AuthService(context),
          ),
          Provider(
            create: (context) => HomeController(
              context.read(),
              context.read(),
            ),
          )
        ],
        child: const HomePage(),
      );
}
