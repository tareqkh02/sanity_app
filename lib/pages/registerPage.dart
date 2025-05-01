import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const RegisterScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String passwordStrength = '';
  Color passwordStrengthColor = Colors.grey;

  bool isLoading = false;

  void _evaluatePasswordStrength(String password) {
    if (password.length < 6) {
      passwordStrength = 'Too short';
      passwordStrengthColor = Colors.red;
    } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(password)) {
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

  bool _isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  Future<void> _registerUser() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showSnackBar("All fields are required");
      return;
    }

    if (!_isValidEmail(email)) {
      _showSnackBar("Invalid email format");
      return;
    }

    if (password != confirmPassword) {
      _showSnackBar("Passwords do not match");
      return;
    }

    final passwordRegExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
    if (!passwordRegExp.hasMatch(password)) {
      _showSnackBar("Password must be at least 8 characters and include:\n- 1 uppercase\n- 1 lowercase\n- 1 number");
      return;
    }

    setState(() => isLoading = true);

    // register api
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  Widget buildRoundedButton({
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
            ? CircularProgressIndicator(color: textColor)
            : Text(label, style: TextStyle(color: textColor)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
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
                  color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Your Name',
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Your Email',
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _passwordController,
                obscureText: true,
                onChanged: _evaluatePasswordStrength,
                decoration: InputDecoration(
                  hintText: 'Your Password',
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
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
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              buildRoundedButton(
                label: "Register",
                onPressed: _registerUser,
                isLoading: isLoading,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Expanded(
                    child: Divider(thickness: 1, endIndent: 10),
                  ),
                  Text(
                    'Already have account',
                    style: TextStyle(
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                    ),
                  ),
                  const Expanded(
                    child: Divider(thickness: 1, indent: 10),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              buildRoundedButton(
                label: "Back to Login",
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
