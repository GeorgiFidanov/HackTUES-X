import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../components/TextPlaceholder.dart';
import '../components/SecurePlaceholder.dart';
import '../components/TextButton.dart';

import 'Get_device_data.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 140,
          height: 140,
          child: Image.asset('assets/icon.png'),
        ),
        TextPlaceholder(text: 'Email', controller: emailController),
        SizedBox(height: 20),
        SecurePlaceholder(labelText: 'Password', controller: passwordController),
        SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          height: 50.0,
          child: ElevatedButton(
            onPressed: () {
              loginUser(context);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Color(0xFF5995F7),
              backgroundColor: Color(0xFFB9D6FB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text('Login'),
          ),
        ),
        RegisterButton(),
      ],
    );
  }

  void loginUser(BuildContext context) async {
    final url = Uri.parse('http://192.168.166.172:8000/api/login');

    final Map<String, String> parameters = {
      "email": emailController.text,
      "password": passwordController.text,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(parameters),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'] as String;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeviceDetailsPage(token: token),
          ),
        );
        print(token);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed')),
        );
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }
}
