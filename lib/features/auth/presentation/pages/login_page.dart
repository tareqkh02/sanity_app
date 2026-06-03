import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_chat/core/router/app_router.dart';
import 'package:safe_chat/features/auth/presentation/cubit/user_auth_cubit.dart';
import 'package:safe_chat/features/auth/presentation/cubit/user_auth_state.dart';
import 'package:safe_chat/features/auth/presentation/pages/register_page.dart';
import 'package:safe_chat/features/auth/presentation/widgets/auth_button.dart';
import 'package:safe_chat/features/auth/presentation/widgets/social_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String _errorMessage = '';

  void signInWithGoogle() {}

  void handleLogin() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter both email and password.';
      });
      return;
    }

    context.read<UserAuthCubit>().signIn(email, password);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocConsumer<UserAuthCubit, UserAuthState>(
        listener: (context, state) {
          if (state is UserAuthSuccess) {
            context.go(AppRoutes.home);
          }
          if (state is UserAuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                    color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField(
                  controller: emailController,
                  hint: 'Your Email',
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: passwordController,
                  hint: 'Your Password',
                  obscure: true,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      color:
                        theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                  if (_errorMessage.isNotEmpty)
                    Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 20),
                AuthButton(text: "Log In", onPressed: handleLogin),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Expanded(child: Divider(thickness: 1, endIndent: 10)),
                    Text(
                          'Or',
                          style: TextStyle(
                            color:
                                theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                      ),
                    ),
                    const Expanded(child: Divider(thickness: 1, indent: 10)),
                  ],
                ),
                const SizedBox(height: 15),
                SocialButton(
                  icon: FontAwesomeIcons.google,
                  text: "Sign In With Google",
                  action: signInWithGoogle,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color:
                          theme.textTheme.bodySmall?.color?.withValues(alpha: 0.9),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 156, 156, 160)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 96, 96, 96),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        style: const TextStyle(
          color: Colors.white,
          fontFamily: "Avenir",
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        autocorrect: false,
      ),
    );
  }
}
