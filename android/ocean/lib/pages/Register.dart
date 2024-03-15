import 'package:flutter/material.dart';

import '../components/TextPlaceholder.dart';
import '../components/SecurePlaceholder.dart';
import '../components/Button.dart';

import 'main.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center, // Center the children horizontally
              children: [
                SizedBox(
                  width: 140,
                  height: 140,
                  child: Image.asset('assets/icon.png'),
                ),
                SizedBox(height: 20),
                TextPlaceholder(text: 'Name'),
                SizedBox(height: 20),
                TextPlaceholder(text: 'Email'),
                SizedBox(height: 20),
                SecurePlaceholder(labelText: 'Password'),
                SizedBox(height: 20),
                SecurePlaceholder(labelText: 'Confirm Password'),
                SizedBox(height: 20),
                Button(buttonText: 'Register', pageToNavigate: MainApp()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
