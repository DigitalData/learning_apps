import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../settings.dart';
import './pet_list.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();

  static LatLng randomLatLng() {
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
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final PanelController _pc = PanelController();
  final Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late Map<String, PetItem> pets = PetItem.testingPetList();
  final LatLng _actPosition = const LatLng(-35.3035, 149.1227);
  late LatLng _currentPosition =
      (markers.isEmpty ? _actPosition : pets.values.first.position);

  late ScrollController _scrollController;

  /// FUNCTIONS

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    for (var pet in pets.values) {
      pet.mapController = controller;
    }
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
    mapController
        .animateCamera(CameraUpdate.newLatLng(MapScreen.randomLatLng()));
  }

  double _panelHeight() {
    if (!_pc.isAttached) return 84;
    return (_pc.panelPosition) * 320 + 116;
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
        body: SlidingUpPanel(
          controller: _pc,
          body: Stack(children: <Widget>[
            GoogleMap(
              padding: EdgeInsets.only(left: 8, bottom: _panelHeight()),
              onMapCreated: _onMapCreated,
              onCameraMove: _onCameraMove,
              // markers: markers.values.toSet(),
              markers: pets.values.toSet(),
              initialCameraPosition:
                  CameraPosition(target: _currentPosition, zoom: 11.0),
              zoomControlsEnabled: false,
            ),
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: Padding(
            //       padding: const EdgeInsets.only(bottom: 128, right: 16),
            //       child: FloatingActionButton(
            //           child: const Icon(Icons.save),
            //           backgroundColor: primaryColour,
            //           onPressed: _saveCurrentLocation)),
            // ),
            // Align(
            //   alignment: Alignment.bottomLeft,
            //   child: Padding(
            //     padding: const EdgeInsets.only(bottom: 128, left: 16),
            //     child: FloatingActionButton(
            //         child: const Icon(Icons.travel_explore_rounded),
            //         backgroundColor: primaryColour,
            //         onPressed: _randomTravel),
            //   ),
            // ),
          ]),
          borderRadius: radius,
          minHeight: 30,
          maxHeight: 350,
          panelSnapping: false,
          panelBuilder: (ScrollController sc) {
            _scrollController = sc;
            return VerticalPetList(pets: pets, scrollController: sc);
          },
          // collapsed: Container(
          //   child: HorizontalPetList(pets: PetItem.testingPetList()),
          // ),
        )

        // Stack(
        //   children: <Widget>[
        //     GoogleMap(
        //       padding: EdgeInsets.only(bottom: _scrollHeight()),
        //       onMapCreated: _onMapCreated,
        //       onCameraMove: _onCameraMove,
        //       markers: markers.values.toSet(),
        //       initialCameraPosition:
        //           CameraPosition(target: _currentPosition, zoom: 11.0),
        //       zoomControlsEnabled: false,
        //     ),
        //     Align(
        //       alignment: Alignment.bottomRight,
        //       child: Padding(
        //           padding: const EdgeInsets.all(16),
        //           child: FloatingActionButton(
        //               child: const Icon(Icons.save),
        //               backgroundColor: primaryColour,
        //               onPressed: _saveCurrentLocation)),
        //     ),
        //     Align(
        //       alignment: Alignment.bottomLeft,
        //       child: Padding(
        //         padding: const EdgeInsets.all(16),
        //         child: FloatingActionButton(
        //             child: const Icon(Icons.travel_explore_rounded),
        //             backgroundColor: primaryColour,
        //             onPressed: _randomTravel),
        //       ),
        //     ),
        //     ScrollableList()
        //   ],
        // ),
        );
  }
}
