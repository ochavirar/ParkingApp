import 'package:flutter/material.dart';
import 'package:parking_app/providers/log_in_provider.dart';
import 'package:parking_app/providers/parking_spots_provider.dart';
import 'package:parking_app/providers/sign_up_provider.dart';
import 'package:parking_app/screens/login_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => SignUpProvider()),
    ChangeNotifierProvider(create: (_) => LogInProvider()),
    ChangeNotifierProvider(create: (_) => ParkingSpotProvider()),
  ],
  child: const myApp()
  )
);

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ParkingApp',
    theme: ThemeData(
      appBarTheme: const AppBarTheme(
        color:Color.fromARGB(255, 47, 125, 121),
      ), 
    ),
    home: LoginPage(),
  );
  }
}
