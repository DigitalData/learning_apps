import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './settings.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  // If a key exists then use it.
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;
  late Marker reticle;
  final MarkerId reticleID = MarkerId("reticle");

  // position on the map.
  LatLng _currentPosition = const LatLng(-37.849957, 144.987407);

  final Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    setState(() {
      reticle = Marker(
          markerId: reticleID,
          position: _currentPosition,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure));
      markers[reticleID] = reticle;
    });
  }

  void _travel() {
    mapController.animateCamera(CameraUpdate.newLatLng(_randomLatLng()));
  }

  void _saveCurrentLocation() {
    final id = MarkerId(markers.length.toString());
    final pos = _currentPosition;
    final newMarker = Marker(
        markerId: id,
        position: pos,
        infoWindow: InfoWindow(
            title: id.toString(), snippet: id.toString() + "th marker"));

    setState(() {
      markers[id] = newMarker;
    });
  }

  void _onCameraMove(CameraPosition pos) {
    setState(() {
      _currentPosition = pos.target;
      reticle = Marker(
          markerId: reticleID,
          position: _currentPosition,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure));
      markers[reticleID] = reticle;
    });
  }

  LatLng _randomLatLng() {
    final randomGen = Random.secure();

    const List<double> bounds = [
      113.338953078,
      -43.6345972634,
      153.569469029,
      -10.6681857235
    ];

    double lat = (bounds[3] - bounds[1]) * randomGen.nextDouble() + bounds[1];
    double lng = (bounds[2] - bounds[0]) * randomGen.nextDouble() + bounds[0];
    return LatLng(lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Map Sample App"),
            backgroundColor: primaryColour,
            actions: <Widget>[
              IconButton(onPressed: _travel, icon: Icon(Icons.flight))
            ],
          ),
          body: GoogleMap(
            padding: const EdgeInsets.only(bottom: 70, right: 12.5),
            onMapCreated: _onMapCreated,
            onCameraMove: _onCameraMove,
            markers: markers.values.toSet(),
            initialCameraPosition:
                CameraPosition(target: _currentPosition, zoom: 11.0),
          ),
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.save),
              backgroundColor: primaryColour,
              onPressed: _saveCurrentLocation)),
    );
  }
}



// -- For the Word Pair App
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Test',
//         theme: ThemeData(
//             primaryColor: Colors.red[300],
//             colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)),
//         home: RandomWords());
//   }
// }
