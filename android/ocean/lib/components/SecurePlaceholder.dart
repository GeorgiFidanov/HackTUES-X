import 'package:flutter/material.dart';

class SecurePlaceholder extends StatefulWidget {
  final String labelText;
  const SecurePlaceholder({
    Key? key,
    required this.labelText,
  }) : super(key: key);

  @override
  _SecurePlaceholderState createState() => _SecurePlaceholderState();
}

class _SecurePlaceholderState extends State<SecurePlaceholder> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      decoration: InputDecoration(
        filled: true,
        labelText: widget.labelText.isNotEmpty ? widget.labelText : null,
        fillColor: Color(0xFFE8E8E9),
        labelStyle: TextStyle(color: Color(0xFFB7B7BA)), 
        border: OutlineInputBorder(
          borderSide: BorderSide.none, 
          borderRadius: BorderRadius.circular(8.0),
        ),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}