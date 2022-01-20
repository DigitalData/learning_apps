import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../settings.dart';
import './map_screen.dart';

class PetItem extends Marker {
  GoogleMapController? mapController;
  final String name;
  final String? type;
  final String? description;
  final Image? img;
  late CircleAvatar avatar =
      CircleAvatar(child: (img ?? Text(name.substring(0, 2))));

  PetItem(
      {required this.name,
      this.img,
      this.type,
      this.description,
      this.mapController})
      : super(
            position: MapScreen.randomLatLng(),
            markerId: MarkerId(name),
            infoWindow: InfoWindow(
                title: name, snippet: (description ?? (type ?? ""))));

  void _onTapped() {
    mapController?.animateCamera(CameraUpdate.newLatLng(position));
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
        leading: avatar);
  }

  Widget asAvatar() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: avatar,
    );
    // return SizedBox(width: 64, child: avatar);
  }

  static Map<String, PetItem> testingPetList() {
    final Map<String, PetItem> testPets = <String, PetItem>{};

    for (int i = 0; i < 20; i++) {
      String newName = "pet $i";
      String? newType, newDescription;

      final rand = Random();

      if (rand.nextBool()) newType = "Type $i";
      if (rand.nextBool()) newDescription = "Desc $i";
      testPets[newName] =
          PetItem(name: newName, type: newType, description: newDescription);
    }

    return testPets;
  }
}

class VerticalPetList extends StatefulWidget {
  final Map<String, PetItem> pets;
  final ScrollController? scrollController;

  VerticalPetList({required this.pets, this.scrollController});

  @override
  State<VerticalPetList> createState() => _VerticalPetListState(
      pets: this.pets, scrollController: this.scrollController!);
}

class _VerticalPetListState extends State<VerticalPetList> {
  final Map<String, PetItem> pets;
  final ScrollController scrollController;
  _VerticalPetListState({required this.pets, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final Iterable<ListTile> tiles = pets.values.toList().map((PetItem pet) {
      return pet.asListTile();
    });

    final List<Widget> divided =
        ListTile.divideTiles(context: context, tiles: tiles).toList();

    final List<Widget> finalTiles = <Widget>[
      const SizedBox(
        height: 12.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 30,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
          ),
        ],
      ),
      const SizedBox(
        height: 18.0,
      ),
      ...divided
    ];

    return ClipRRect(
        borderRadius: radius,
        child: Column(children: <Widget>[
          Column(children: <Widget>[
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            const SizedBox(
              height: 18.0,
            )
          ]),
          SizedBox(
              height: 315,
              child: ListView(
                children: divided,
                controller: scrollController,
              ))
        ]));
  }
}

// class HorizontalPetList extends StatelessWidget {
//   final List<PetItem> pets;
//   HorizontalPetList({required this.pets});

//   @override
//   Widget build(BuildContext context) {
//     final Iterable<Widget> tiles = pets.map((PetItem pet) {
//       return pet.asAvatar();
//     });

//     final List<Widget> finalTiles = <Widget>[
//       const SizedBox(
//         height: 12.0,
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Container(
//             width: 30,
//             height: 5,
//             decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.all(Radius.circular(12.0))),
//           ),
//         ],
//       ),
//       const SizedBox(
//         height: 18.0,
//       ),
//       SizedBox(
//         height: 64,
//         child: ListView(
//           scrollDirection: Axis.horizontal,
//           children: tiles.toList(),
//           shrinkWrap: true,
//         ),
//       )
//     ];

//     return Container(
//         decoration: BoxDecoration(borderRadius: radius, color: primaryColour),
//         child: ListView(
//           children: finalTiles,
//           shrinkWrap: true,
//         ));
//   }
// }
