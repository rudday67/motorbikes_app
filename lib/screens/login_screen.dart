import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motorbikes_app/cubit/auth/auth_cubit.dart';
import 'package:motorbikes_app/dto/login.dart';
import 'package:motorbikes_app/services/data_service.dart';
import 'package:motorbikes_app/utils/constants.dart';
import 'package:motorbikes_app/utils/secure_storage_util.dart';
import 'home_screen.dart'; // Import your home screen file

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();   
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final String _validEmail = "rudy";
  final String _validPassword = "123";

  void sendLogin(context, AuthCubit authCubit, {String message = ''}) async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final response = await DataService.sendLoginData(email, password);
    if (response.statusCode == 200) {
      debugPrint("sending success");
      final data = jsonDecode(response.body);
      final loggedIn = Login.fromJson(data);
      await SecureStorageUtil.storage
          .write(key: tokenStoreName, value: loggedIn.accessToken);

      authCubit.login(loggedIn.accessToken);
      Navigator.pushReplacementNamed(context, "/home");
      debugPrint(loggedIn.accessToken);
    } else {
      debugPrint("failed");
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content:
                Text(message.isEmpty ? 'Invalid email or password' : message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Login',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              'assets/images/icon.png',
              height: 200,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 40),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                String email = _emailController.text;
                String password = _passwordController.text;

                if (email == _validEmail && password == _validPassword) {
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  sendLogin(context, authCubit,
                      message: 'Invalid email or password');
                }
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
