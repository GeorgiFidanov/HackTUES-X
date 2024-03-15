import 'package:flutter/material.dart';

import '../pages/Register.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Register()),
          );
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.black, // Text color
        ),
        child: Text(
          'Create an account',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}