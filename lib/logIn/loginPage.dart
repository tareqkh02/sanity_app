import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_chat/Apis/Apis.dart';
import 'package:safe_chat/pages/homePage.dart';

import 'sing_in/registerPage.dart';

class LoginScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const LoginScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String _errorMessage = '';

  void handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter both email and password.';
      });
      return;
    }

    print("Logging in with: $email");

    final result = await signInUser(email, password, true, context);

    if (result != null && result['success'] == true) {
      print('✅ Login successful');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      setState(() {
        _errorMessage =
            result?['message'] ?? 'Invalid credentials, please try again.';
      });
    }
  }

  Future<void> login(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;

    // login api
  }

  Future<void> signInWithGoogle() async {
    // sign with google api
  }

  Widget buildButton(String text, VoidCallback onPressed) {
    final isDark = widget.isDarkMode;
    final buttonColor = isDark ? Colors.white : Colors.black;
    final textColor = isDark ? Colors.black : Colors.white;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

  Widget buildSocialButton({
    required IconData icon,
    required String text,
    required ThemeData theme,
    required VoidCallback action,
  }) {
    final isDark = widget.isDarkMode;
    final buttonColor = isDark ? Colors.white : Colors.black;

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: action,
        icon: Icon(icon, color: buttonColor),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Text(
            text,
            style: TextStyle(color: buttonColor),
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: buttonColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  IconButton(
                    icon: Icon(
                      isDark ? Icons.light_mode : Icons.dark_mode,
                      color: theme.iconTheme.color,
                    ),
                    onPressed: widget.toggleTheme,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                'Sanity',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              Text(
                "Let's get you in to Sanity",
                style: TextStyle(
                  color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 156, 156, 160),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      hintText: 'Your Email',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.transparent,
                      )),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.transparent,
                      )),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.transparent,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.transparent,
                      )),
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 96, 96, 96),
                      )),
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.normal,
                      fontSize: 14),
                  autocorrect: false,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 156, 156, 160),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: 'Your Password',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.transparent,
                      )),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.transparent,
                      )),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.transparent,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.transparent,
                      )),
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 96, 96, 96),
                      )),
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.normal,
                      fontSize: 14),
                  autocorrect: false,
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                  ),
                ),
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child:
                      Text(_errorMessage, style: TextStyle(color: Colors.red)),
                ),
              const SizedBox(height: 20),
              buildButton("Log In", () {
                handleLogin();
              }),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      thickness: 1,
                      endIndent: 10,
                    ),
                  ),
                  Text(
                    'Or',
                    style: TextStyle(
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      thickness: 1,
                      indent: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              buildSocialButton(
                icon: FontAwesomeIcons.google,
                text: "Sign In With Google",
                theme: theme,
                action: signInWithGoogle,
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(
                        isDarkMode: widget.isDarkMode,
                        toggleTheme: widget.toggleTheme,
                      ),
                    ),
                  );
                },
                child: Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.9),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
