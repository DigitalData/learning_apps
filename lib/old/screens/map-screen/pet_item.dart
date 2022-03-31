import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../settings.dart';
import './map_screen.dart';

class PetItem {
  ScreenshotController screenshotController = ScreenshotController();

  GoogleMapController? mapController;
  final String name;
  final String? type;
  final String? description;
  final Image? img;
  Marker marker;

  PetItem(
      {required this.name,
      this.img,
      this.type,
      this.description,
      this.mapController})
      : marker = Marker(
            position: MapScreen.randomLatLng(),
            markerId: MarkerId(name),
            infoWindow: InfoWindow(
                title: name, snippet: (description ?? (type ?? ""))));

  void init() {
    screenshotController.capture().then((capturedImage) {
      if (capturedImage == null) return;
      marker = Marker(
          position: marker.position,
          markerId: marker.markerId,
          icon: BitmapDescriptor.fromBytes(capturedImage),
          infoWindow: marker.infoWindow);
    });
  }

  void _onTapped() {
    mapController?.animateCamera(CameraUpdate.newLatLng(marker.position));
  }

  void _onBatteryPressed() {}

  void _onEditPressed() {
    print(name);
  }

  ListTile asListTile() {
    return ListTile(
      onTap: _onTapped,
      title: Text(name),
      // subtitle: Text(description ?? (type ?? "")),
      trailing: Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          Column(children: <Widget>[
            Transform.rotate(
              angle: pi / 2,
              child: IconButton(
                  onPressed: _onBatteryPressed,
                  icon: const Icon(Icons.battery_full_rounded)),
            )
          ]),
          IconButton(onPressed: _onEditPressed, icon: const Icon(Icons.edit))
        ],
      ),
      leading: Screenshot(
        controller: screenshotController,
        child: asAvatar(),
      ),
    );
  }

  Widget asAvatar() {
    return CircleAvatar(
        radius: 20,
        backgroundColor: Settings.colours.primary,
        child: CircleAvatar(
          foregroundColor: Colors.white,
          backgroundColor: Settings.colours.tertiary,
          radius: 16,
          child: (img ?? Text(name.substring(0, 2))),
        ));
  }

  static Map<String, PetItem> testingPetList() {
    final Map<String, PetItem> testPets = <String, PetItem>{};

    for (int i = 0; i < 5; i++) {
      String newName = "p${i}et";
      String? newType, newDescription;

      final rand = Random();

      if (rand.nextBool()) newType = "Type $i";
      if (rand.nextBool()) newDescription = "Desc $i";
      testPets[newName] =
          PetItem(name: newName, type: newType, description: newDescription);
      testPets[newName]?.init();
    }

    return testPets;
  }
}
