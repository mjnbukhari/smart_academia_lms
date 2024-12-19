import "dart:async";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

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
