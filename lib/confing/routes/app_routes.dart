import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_chat/features/auth/presentation/loginPage.dart';
import 'package:safe_chat/features/auth/presentation/registerPage.dart';
import 'package:safe_chat/pages/homePage.dart';

class Routes {
  static const String login = '/login';
  static const String singup = '/signup';
  static const String home = '/home';
}

final GoRouter appRouter = GoRouter(initialLocation: Routes.login, routes: [
  GoRoute(
    path: Routes.login,
    builder: (context, state) =>
        LoginScreen(isDarkMode: false, toggleTheme: () {}),
  ),
  GoRoute(
      path: Routes.singup,
      builder: (context, state) =>
          RegisterScreen(isDarkMode: false, toggleTheme: () {})),
  GoRoute(path: Routes.home, builder: (context, state) => HomePage()),
]);
