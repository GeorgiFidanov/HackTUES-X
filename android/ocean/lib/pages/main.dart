import 'package:flutter/material.dart';

import '../components/TextPlaceholder.dart';
import '../components/SecurePlaceholder.dart';
import '../components/Button.dart';
import '../components/TextButton.dart';

import 'Choose_device.dart';


void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 SizedBox(
                  width: 140,
                  height: 140,
                  child: Image.asset('assets/icon.png'),
                ),
                SizedBox(height: 20),
                TextPlaceholder(text: 'Email'),
                SizedBox(height: 20),
                SecurePlaceholder(labelText: 'Password'),
                SizedBox(height: 20),
                Button(buttonText: 'Login', pageToNavigate: Choose_device(),), //Add functionality
                RegisterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}