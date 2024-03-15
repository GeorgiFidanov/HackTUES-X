import 'package:flutter/material.dart';

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
                Image.asset('assets/icon.png'), // Image above placeholders
                SizedBox(height: 20),
                TextPlaceholder(),
                SizedBox(height: 20),
                SecurePlaceholder(),
                SizedBox(height: 20),
                SubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextPlaceholder extends StatelessWidget {
  const TextPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Enter your text',
        border: OutlineInputBorder(),
      ),
    );
  }
}

class SecurePlaceholder extends StatefulWidget {
  const SecurePlaceholder({Key? key}) : super(key: key);

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
        labelText: 'Enter your password',
        border: OutlineInputBorder(),
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

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add your button press logic here
      },
      child: Text('Submit'),
    );
  }
}
