import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:parking_app/screens/first_page.dart';
=======
import 'package:http/http.dart' as http;

Future<void> fetchMalls() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:3000/malls/'));
  print(response.body);
}
>>>>>>> c06dbb728c09f2403b50e76bc2a998484fd05f8c

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
<<<<<<< HEAD
      home: HomePage()
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Material App Bar')
=======
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              fetchMalls();
            },
            child: const Text('Elevated Button'),
          )
>>>>>>> c06dbb728c09f2403b50e76bc2a998484fd05f8c
        ),
      ),
      body: const FirstPage()
    );
  }
}