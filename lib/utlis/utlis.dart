import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utlis {
  static String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    if (value?.trim() == "") {
      return 'Enter Email Address';
    } else if (!regex.hasMatch(value!)) {
      return 'Please Enter Valid Email';
    } else {
      return null;
    }
  }

  static String? passValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please this field must be filled';
    } else if (value.length < 6) {
      return 'Please enter minimum 6 chars';
    } else {
      return null;
    }
  }

  void showSuccess(
    context,
    String message, {
    bool shouldDismiss = true,
  }) {
    Timer.run(
      () => _showAlert(
        context,
        message,
        Colors.white,
        CupertinoIcons.check_mark_circled_solid,
        const Color.fromRGBO(91, 180, 107, 1),
        shouldDismiss,
      ),
    );
  }

  void showInfo(context, String message, {bool shouldDismiss = true}) {
    Timer.run(
      () => _showAlert(
        context,
        message,
        const Color.fromARGB(255, 177, 230, 255),
        Icons.info_outline,
        const Color.fromRGBO(54, 105, 214, 1),
        shouldDismiss,
      ),
    );
  }

  void showError(context, String message, {bool shouldDismiss = true}) {
    Timer.run(
      () => _showAlert(
        context,
        message,
        const Color(0xFFFDE2E1),
        Icons.error_outline,
        Colors.red,
        shouldDismiss,
      ),
    );
  }

  void _showAlert(
    BuildContext context,
    String message,
    Color color,
    IconData icon,
    Color iconColor,
    bool shouldDismiss,
  ) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: color,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        behavior: SnackBarBehavior.floating,
        elevation: 2,
        content: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          label: "Close",
          onPressed: scaffold.hideCurrentSnackBar,
          textColor: Colors.red,
        ),
      ),
    );
  }
}
