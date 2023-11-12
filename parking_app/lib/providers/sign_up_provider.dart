import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpProvider with ChangeNotifier{

  static const String _signUpLink = 'http://localhost:3000/user';

  Future<void> signUp(String name, String email, String password, String confirmationPassword) async {
    final Map<String, dynamic> signUpData = {
      'name': name,
      'email': email,
      'password': password,
      'confirmationPassword': confirmationPassword
    };

    if(password != confirmationPassword) {
      throw const HttpException('Passwords do not match');
    }

    try {
      final response = await http.post(
        Uri.parse(_signUpLink),
        body: json.encode(signUpData),
        headers: {'Content-Type': 'application/json'}
      );

      final responseData = json.decode(response.body);
      
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      rethrow;
    }
  }
}