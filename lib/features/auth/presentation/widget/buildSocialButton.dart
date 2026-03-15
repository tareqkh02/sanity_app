import 'package:flutter/material.dart';


 Widget buildSocialButton({
    required IconData icon,
    required String text,
    required ThemeData theme,
    required VoidCallback action,
  }) {

    final buttonColor = Colors.white ;

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