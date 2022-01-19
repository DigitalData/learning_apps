import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../settings.dart';
import './scrollable_list.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final LatLng _actPosition = const LatLng(-35.3035, 149.1227);
  late LatLng _currentPosition =
      (markers.isEmpty ? _actPosition : markers.values.first.position);

  /// FUNCTIONS

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
    });
  }

  void _randomTravel() {
    mapController.animateCamera(CameraUpdate.newLatLng(_randomLatLng()));
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

  double _scrollHeight() {
    return 80;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample Map App"),
        backgroundColor: primaryColour,
        actions: <Widget>[
          IconButton(onPressed: _randomTravel, icon: const Icon(Icons.flight))
        ],
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            padding: EdgeInsets.only(bottom: _scrollHeight()),
            onMapCreated: _onMapCreated,
            onCameraMove: _onCameraMove,
            markers: markers.values.toSet(),
            initialCameraPosition:
                CameraPosition(target: _currentPosition, zoom: 11.0),
            zoomControlsEnabled: false,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: FloatingActionButton(
                    child: const Icon(Icons.save),
                    backgroundColor: primaryColour,
                    onPressed: _saveCurrentLocation)),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FloatingActionButton(
                  child: const Icon(Icons.travel_explore_rounded),
                  backgroundColor: primaryColour,
                  onPressed: _randomTravel),
            ),
          ),
          ScrollableList()
        ],
      ),
    );
  }
}
