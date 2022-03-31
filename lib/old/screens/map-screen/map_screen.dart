import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../settings.dart';
import './pet_list.dart';
import './pet_item.dart';

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
  late Map<String, PetItem> pets = PetItem.testingPetList();
  final LatLng _actPosition = const LatLng(-35.3035, 149.1227);
  late LatLng _currentPosition = _actPosition;
  // (pets.isEmpty ? _actPosition : pets.values.first.marker.position);
  double _mapPadding = 116;

  late ScrollController _scrollController;

  /// FUNCTIONS

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    for (var pet in pets.values) {
      pet.mapController = controller;
    }

    _travel(pets.values.first.marker.position);
  }

  void _onCameraMove(CameraPosition pos) {
    setState(() {
      _currentPosition = pos.target;
    });
  }

  void _travel(LatLng pos) {
    mapController.animateCamera(CameraUpdate.newLatLng(pos));
  }

  void _randomTravel() {
    _travel(MapScreen.randomLatLng());
  }

  double _panelHeight() {
    if (!_pc.isAttached) return 84;
    return (_pc.panelPosition) *
            (Settings.panel.maxHeight - Settings.panel.minHeight) +
        116;
  }

  void _onPanelSlide(double pos) {
    setState(() {
      _mapPadding = (_pc.panelPosition) *
              (Settings.panel.maxHeight - Settings.panel.minHeight) +
          110;
    });
  }

  Set<Marker> _getMarkers() {
    return pets.values.map((p) => p.marker).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sample Pet Tracker App"),
          backgroundColor: Settings.colours.primary,
          actions: <Widget>[
            IconButton(onPressed: _randomTravel, icon: const Icon(Icons.flight))
          ],
        ),
        body: SlidingUpPanel(
          controller: _pc,
          body: Stack(children: <Widget>[
            GoogleMap(
              padding: EdgeInsets.only(left: 8, bottom: _mapPadding),
              onMapCreated: _onMapCreated,
              onCameraMove: _onCameraMove,
              // markers: markers.values.toSet(),
              markers: _getMarkers(),
              initialCameraPosition:
                  CameraPosition(target: _currentPosition, zoom: 11.0),
              zoomControlsEnabled: false,
            ),
          ]),
          borderRadius: Settings.borderRadius,
          minHeight: Settings.panel.minHeight,
          maxHeight: Settings.panel.maxHeight,
          onPanelSlide: _onPanelSlide,
          panelSnapping: false,
          color: Settings.colours.primary,
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
        //               backgroundColor: Settings.colours.primary,
        //               onPressed: _saveCurrentLocation)),
        //     ),
        //     Align(
        //       alignment: Alignment.bottomLeft,
        //       child: Padding(
        //         padding: const EdgeInsets.all(16),
        //         child: FloatingActionButton(
        //             child: const Icon(Icons.travel_explore_rounded),
        //             backgroundColor: Settings.colours.primary,
        //             onPressed: _randomTravel),
        //       ),
        //     ),
        //     ScrollableList()
        //   ],
        // ),
        );
  }
}
