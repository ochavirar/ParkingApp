import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LogInProvider with ChangeNotifier{

  static const String _signUpLink = 'http://localhost:3000/user/';

  String email = '';
  String password = '';
  String logged_id = '';

  get id => logged_id;

  Future<bool> logIn(BuildContext context, String email, String password) async {
    final response = await http.get(Uri.parse(_signUpLink + email));
    if(response.statusCode == 200){
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if(responseData['password'] == password){
        logged_id = responseData['_id'];
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}