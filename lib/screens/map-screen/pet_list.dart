import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../settings.dart';
import './pet_item.dart';

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

  Widget _buildDragHandle() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 14),
          child: Container(
            width: 30,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(Radius.circular(12.0))),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Iterable<ListTile> tiles = pets.values.toList().map((PetItem pet) {
      return pet.asListTile();
    });

    final List<Widget> divided =
        ListTile.divideTiles(context: context, tiles: tiles).toList();

    return ClipRRect(
        borderRadius: radius,
        child: Column(children: <Widget>[
          _buildDragHandle(),
          Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                    // color: Settings.colours.secondary,
                    color: Colors.white,
                    borderRadius: Settings.borderRadius,
                    // border: Border.all(
                    //     color: primaryColour,
                    //     style: BorderStyle.solid,
                    //     width: 2)
                  ),
                  child: ClipRRect(
                    borderRadius: Settings.borderRadius,
                    child: ListView(
                      children: divided,
                      controller: scrollController,
                    ),
                  ))),

          // Container(
          //     decoration: BoxDecoration(
          //         borderRadius: radius,
          //         border: Border.all(color: primaryColour)),
          //     child: ClipRRect(
          //       borderRadius: radius,
          //       child: ListView(
          //         children: divided,
          //         controller: scrollController,
          //       ),
          //     )),
          // Expanded(
          //     child: ClipRRect(
          //   borderRadius: radius,
          //   child: ListView(
          //     children: divided,
          //     controller: scrollController,
          //   ),
          // ))
          // ListView(
          //   children: divided,
          //   controller: scrollController,
          // )
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
