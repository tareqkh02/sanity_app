import 'package:go_router/go_router.dart';
import 'package:safe_chat/features/auth/presentation/pages/login_page.dart';
import 'package:safe_chat/features/auth/presentation/pages/register_page.dart';
import 'package:safe_chat/features/chat/presentation/pages/home_page.dart';

class AppRoutes {
  AppRoutes._();

  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.signup,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
