import 'package:flutter/material.dart';

class TextPlaceholder extends StatelessWidget {
  final String text;
  final TextEditingController controller;

  const TextPlaceholder({
    Key? key,
    required this.text,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: text,
        filled: true,
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