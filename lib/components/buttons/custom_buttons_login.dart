import 'package:flutter/material.dart';


class CustomLoginButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

   const CustomLoginButton({super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 345,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF01398D), // Button background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // Rounded corners
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white, // Text color
            fontSize: 16, // Text size
            fontWeight: FontWeight.bold, // Text weight
          ),
        ),
      ),
    );
  }
}

