import 'package:flutter/material.dart';
import 'package:parking_app/screens/map_page.dart';

// Main Screen container, just one widget for the container itself.
class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainScreenContainer();
  }
}

/// Main screen container. Here we can find the following: 
/// Main padding
/// Main Center widget
/// Main column for other widgets
class MainScreenContainer extends StatelessWidget {
  const MainScreenContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            YouParkBanner(), // Main banner located in the top of  the screen
            AppMotto(), // Main image and app motto
            AppBottomButton() // Bottom button to star reserving a parking spot
          ],
        ),
      ),
    );
  }
}

/// Main banner with the name of the app and the logo
class YouParkBanner extends StatelessWidget {
  const YouParkBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('YouPark', 
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Container(
          color: Colors.black,
          child: const Icon(
            Icons.local_parking, size: 50, color: Colors.yellow
          )
        ),
      ],
    );
  }
}

/// Motto with a support image
class AppMotto extends StatelessWidget {
  const AppMotto({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          'https://i5.walmartimages.com.mx/mg/gm/3pp/asr/9b58f873-e20a-4570-a954-acad65089c2a.1889fc0e80aacc1829255db1278a9920.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF',
          height: 150,
        ),
        const Text(
          'Park Easy, Find Bliss!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25
          ),
        )
      ],
    );
  }
}

///This is the main widget for the bottom button in the app
class AppBottomButton extends StatelessWidget {
  const AppBottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        height: 50,
        onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => const MainMap())
          );
        },
        color: Colors.purple,
        child: const ButtonContent()
      ),
    );
  }
}

///Text content of the button
class ButtonContent extends StatelessWidget {
  const ButtonContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.shopping_cart_checkout,
          color: Colors.white,
        ),
        Text(
          'Select your parking spot',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ],
    );
  }
}