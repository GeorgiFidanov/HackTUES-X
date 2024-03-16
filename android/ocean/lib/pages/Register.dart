import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../components/TextPlaceholder.dart';
import '../components/SecurePlaceholder.dart';
import 'Get_device_data.dart';


class Register extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
                TextPlaceholder(text: 'Name', controller: nameController),
                SizedBox(height: 20),
                TextPlaceholder(text: 'Email', controller: emailController),
                SizedBox(height: 20),
                SecurePlaceholder(labelText: 'Password', controller: passwordController),
                SizedBox(height: 20),
                SecurePlaceholder(labelText: 'Confirm Password', controller: confirmPasswordController),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      registerUser(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color(0xFF5995F7),
                      backgroundColor: Color(0xFFB9D6FB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('Register'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void registerUser(BuildContext context) async {
    final url = Uri.parse('http://192.168.166.172:8000/api/register');

    final Map<String, String> parameters = {
      "name": nameController.text,
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
        // Assuming there's a screen to navigate after registration
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DeviceDetailsPage(token: token)),
        );
        print(token);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed')),
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
