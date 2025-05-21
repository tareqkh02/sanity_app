import 'package:flutter/material.dart';
import 'package:safe_chat/class/AuthProvider.dart';
import 'package:safe_chat/logIn/loginPage.dart';
import 'package:provider/provider.dart';
import 'package:safe_chat/services/ChangeNotifierProvider%20.dart';
import 'package:safe_chat/services/socket_service.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Safe Chat',
        themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: LoginScreen(
          isDarkMode: isDarkMode,
          toggleTheme: toggleTheme,
        ),
      );
    }


   
   
  }

