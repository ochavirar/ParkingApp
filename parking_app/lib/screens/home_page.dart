// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:parking_app/screens/find_spot.dart';
import 'package:parking_app/screens/parking_history.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.9; // Cambia el 0.5 al porcentaje deseado

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "YouPark",
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                ),
              ),
              Image.asset(
                'images/car1.png', // Ajusta la ruta de la imagen según tu proyecto
                width: 500,
                height: 200,
              ),
              Text(
                "Park Easy, Find Bliss!",
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 40), // Espacio entre el texto y el botón
              ElevatedButton(
                onPressed: () {
                  print("Button pressed");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FindSpot()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 109, 49, 237),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: Size(buttonWidth, 50), // Tamaño del botón basado en el porcentaje
                ),
                child: Text(
                  "Select your parking lot",
                  style: TextStyle(
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    print("Button pressed");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ParkingHistory()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: Size(buttonWidth, 50), // Tamaño del botón basado en el porcentaje
                  ),
                  child: Text(
                    "See your parking history",
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}