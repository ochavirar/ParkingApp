import 'package:flutter/material.dart';
import 'package:parking_app/providers/sign_up_provider.dart';
import 'package:parking_app/screens/login_page.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmationPasswordController = TextEditingController();

  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmationPassword = '';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmationPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (text) { 
                _name = text;
              },
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (text) { 
                _email = text;
              },
            ),
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              onChanged: (text) { 
                _password = text;
              },
            ),
            TextField(
              obscureText: true,
              controller: _confirmationPasswordController,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              onChanged: (text) { 
                _confirmationPassword = text;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<SignUpProvider>(context, listen: false).signUp(_name, _email, _password, _confirmationPassword)
                .then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())));
                
              },
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
