import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';  // for specifying coordinates

class MainMap extends StatelessWidget {
  const MainMap({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Map',
      home: MainMapContainer()
    );
  }
}

class MainMapContainer extends StatelessWidget {
  const MainMapContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }
}

class Map extends StatelessWidget {
  const Map({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
          latlong: const LatLng(37.7749, -122.4194), // Initial map center (San Francisco)
          zoom: 13.0,
      )
    );
  }
}