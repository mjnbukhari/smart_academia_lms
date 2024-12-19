import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.isPassword,
    required this.hintText,
    required this.validator,
    required this.controller,
  });

  final String label;
  final bool isPassword;
  final String hintText;
  final String? Function(String?) validator;
  final TextEditingController controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5.0),
        Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 0.01,
                spreadRadius: 0.2,
                offset: Offset(0, 5),
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword ? _obscureText : false,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              filled: true,
              hintText: widget.hintText,
              fillColor: const Color(0xFFE5E2E2),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: _togglePasswordVisibility,
                    )
                  : null,
            ),
            keyboardType: widget.isPassword ? TextInputType.text : TextInputType.emailAddress,
            validator: widget.validator,
          ),
        ),
      ],
    );
  }
}
