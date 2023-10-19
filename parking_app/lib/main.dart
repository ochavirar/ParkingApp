import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> fetchMalls() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:3000/malls/'));
  print(response.body);
}

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
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
        ),
      ),
    );
  }
}