import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_chat/core/router/app_router.dart';
import 'package:safe_chat/features/auth/presentation/cubit/user_auth_cubit.dart';
import 'package:safe_chat/features/auth/presentation/cubit/user_auth_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String passwordStrength = '';
  Color passwordStrengthColor = Colors.grey;
  String _errorMessage = '';
  bool isLoading = false;

  void handleRegister() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter both email and password.';
      });
      return;
    }

    context.read<UserAuthCubit>().signUp(email, password);
  }

  void _evaluatePasswordStrength(String password) {
    if (password.length < 6) {
      passwordStrength = 'Too short';
      passwordStrengthColor = Colors.red;
    } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)')
        .hasMatch(password)) {
      passwordStrength = 'Weak';
      passwordStrengthColor = Colors.orange;
    } else if (password.length >= 8) {
      passwordStrength = 'Strong';
      passwordStrengthColor = Colors.green;
    } else {
      passwordStrength = 'Medium';
      passwordStrengthColor = Colors.blue;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                  'Create Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
                Text(
                  "Let's get started with your new account",
                  style: TextStyle(
                    color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField(
                  controller: _nameController,
                  hint: 'Your Name',
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _emailController,
                  hint: 'Your Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _passwordController,
                  hint: 'Your Password',
                  obscure: true,
                  onChanged: _evaluatePasswordStrength,
                ),
                if (passwordStrength.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Strength: $passwordStrength',
                        style: TextStyle(color: passwordStrengthColor),
                      ),
                    ),
                  ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _confirmPasswordController,
                  hint: 'Confirm Password',
                  obscure: true,
                ),
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 25),
                _buildRoundedButton(
                  label: "Register",
                  onPressed: handleRegister,
                  isLoading: state is UserAuthLoading,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Expanded(child: Divider(thickness: 1, endIndent: 10)),
                    Text(
                      'Already have account',
                      style: TextStyle(
                        color:
                            theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                      ),
                    ),
                    const Expanded(child: Divider(thickness: 1, indent: 10)),
                  ],
                ),
                const SizedBox(height: 15),
                _buildRoundedButton(
                  label: "Back to Login",
                  onPressed: () => Navigator.pop(context),
                ),
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
    TextInputType? keyboardType,
    void Function(String)? onChanged,
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
        onChanged: onChanged,
        keyboardType: keyboardType,
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

  Widget _buildRoundedButton({
    required String label,
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.white : Colors.black;
    final textColor = isDark ? Colors.black : Colors.white;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.black)
            : Text(label, style: TextStyle(color: textColor)),
      ),
    );
  }
}
