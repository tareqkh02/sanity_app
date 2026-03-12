import 'package:flutter/material.dart';
import 'package:safe_chat/Apis/Apis.dart';
import 'package:safe_chat/pages/homePage.dart';

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
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String passwordStrength = '';
  Color passwordStrengthColor = Colors.grey;
  String _errorMessage = '';
  bool isLoading = false;

  void handleRegister() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter both email and password.';
      });
      return;
    }

    print("Logging in with: $email");

    final result = await signUpUser(email, password, name, true , context);

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
              Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 156, 156, 160),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        hintText: 'Your Name',
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
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Avenir",
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                    autocorrect: false,
                  )),
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
                  controller: _emailController,
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
                  keyboardType: TextInputType.emailAddress,
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
                  controller: _passwordController,
                  obscureText: true,
                  onChanged: _evaluatePasswordStrength,
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
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 156, 156, 160),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: 'Confirm Password',
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
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child:
                      Text(_errorMessage, style: TextStyle(color: Colors.red)),
                ),
              const SizedBox(height: 25),
              buildRoundedButton(
                label: "Register",
                onPressed: () {
                  handleRegister();
                },
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
