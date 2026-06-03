import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_chat/core/di/injection_container.dart' as di;
import 'package:safe_chat/core/router/app_router.dart';
import 'package:safe_chat/core/theme/app_theme.dart';
import 'package:safe_chat/features/auth/presentation/cubit/user_auth_cubit.dart';
import 'package:safe_chat/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:safe_chat/features/profile/presentation/cubit/profile_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserAuthCubit>(
          create: (_) => di.sl<UserAuthCubit>(),
        ),
        BlocProvider<ChatCubit>(
          create: (_) => di.sl<ChatCubit>(),
        ),
        BlocProvider<ProfileCubit>(
          create: (_) => di.sl<ProfileCubit>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Safe Chat',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        routerConfig: appRouter,
      ),
    );
  }
}
