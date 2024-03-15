import 'package:flutter/material.dart';

class SecurePlaceholder extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  const SecurePlaceholder({
    Key? key,
    required this.labelText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        labelText: labelText.isNotEmpty ? labelText : null,
        fillColor: Color(0xFFE8E8E9),
        labelStyle: TextStyle(color: Color(0xFFB7B7BA)), 
        border: OutlineInputBorder(
          borderSide: BorderSide.none, 
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
