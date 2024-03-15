import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final Widget pageToNavigate;

  const Button({
    Key? key,
    required this.buttonText,
    required this.pageToNavigate,
  }) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, 
      height: 50.0, 
      child: ElevatedButton(
        onPressed: () {
           Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pageToNavigate),
          );
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Color(0xFF5995F7), 
          backgroundColor: Color(0xFFB9D6FB), // Color of the text
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Adjust the corner radius as needed
          ),
        ),
        child: Text(buttonText),
      ),
    );
  }
}