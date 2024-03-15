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
                 SizedBox(
                  width: 140,
                  height: 140,
                  child: Image.asset('assets/icon.png'),
                ),
                SizedBox(height: 20),
                TextPlaceholder(),
                SizedBox(height: 20),
                SecurePlaceholder(),
                SizedBox(height: 20),
                SubmitButton(),
                RegisterButton(),
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
        labelText: 'Email',
        filled: true,
        fillColor: Color(0xFFE8E8E9), // Background color
        labelStyle: TextStyle(color: Color(0xFFB7B7BA)), // Text color
        border: OutlineInputBorder(
          borderSide: BorderSide.none, // Remove border
          borderRadius: BorderRadius.circular(8.0),
        ),
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
        labelText: 'Password',
        filled: true,
        fillColor: Color(0xFFE8E8E9), // Background color
        labelStyle: TextStyle(color: Color(0xFFB7B7BA)), // Text color
        border: OutlineInputBorder(
          borderSide: BorderSide.none, // Remove border
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

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Match width with parent
      height: 50.0, // Adjust height as needed
      child: ElevatedButton(
        onPressed: () {
          // Add your button press logic here
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Color(0xFF5995F7), 
          backgroundColor: Color(0xFFB9D6FB), // Color of the text
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Adjust the corner radius as needed
          ),
        ),
        child: Text('Login'),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Add your button press logic here
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