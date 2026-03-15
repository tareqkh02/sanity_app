import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_chat/confing/routes/app_routes.dart';
import 'package:safe_chat/confing/them/app_them.dart';
import 'package:safe_chat/core/di/injection_container.dart' as di;
import 'package:safe_chat/features/providers.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: appProviders,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Safe Chat',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        darkTheme: AppThem.lightTheme,
        routerConfig: appRouter,
      ),
    );
  }
}
