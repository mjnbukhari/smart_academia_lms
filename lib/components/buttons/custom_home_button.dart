import 'package:flutter/material.dart';

class CustomHomeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColour;
  final Color textColor;
  final bool showIcon;

  const CustomHomeButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.backgroundColour,
    required this.textColor,
    this.showIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 140,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: backgroundColour, // Background color
          borderRadius: BorderRadius.circular(20.0),
          border: showIcon ? Border.all(width: 0.5, color: Colors.black26) : null,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 1,
              offset: Offset(1, 3),
            ),
          ], // Rounded edges
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: textColor, // Text color
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (showIcon) const SizedBox(width: 10),
            if (showIcon)
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: textColor,
                size: 20,
              )
          ],
        ),
      ),
    );
  }
}
