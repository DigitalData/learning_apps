import 'package:flutter/material.dart';

import '../settings.dart';

class PetItem extends ListTile {
  final String name;
  final Image? img;
  late CircleAvatar avatar =
      CircleAvatar(child: (img ?? Text(name.substring(0, 2))));

  PetItem({required this.name, this.img}) : super();

  ListTile asListTile() {
    return ListTile(title: Text(name), leading: avatar);
  }

  Widget asAvatar() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: avatar,
    );
    // return SizedBox(width: 64, child: avatar);
  }

  static List<PetItem> testingPetList() {
    final List<PetItem> testPets = [];

    for (int i = 0; i < 20; i++) {
      testPets.add(PetItem(name: "pet $i"));
    }

    return testPets;
  }
}

class VerticalPetList extends StatefulWidget {
  final List<PetItem> pets;
  final ScrollController? scrollController;

  VerticalPetList({required this.pets, this.scrollController});

  @override
  State<VerticalPetList> createState() => _VerticalPetListState(
      pets: this.pets, scrollController: this.scrollController!);
}

class _VerticalPetListState extends State<VerticalPetList> {
  final List<PetItem> pets;
  final ScrollController scrollController;
  _VerticalPetListState({required this.pets, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final Iterable<ListTile> tiles = pets.map((PetItem pet) {
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

    return ListView(
      children: finalTiles,
      controller: scrollController,
    );
  }
}

class HorizontalPetList extends StatelessWidget {
  final List<PetItem> pets;
  HorizontalPetList({required this.pets});

  @override
  Widget build(BuildContext context) {
    final Iterable<Widget> tiles = pets.map((PetItem pet) {
      return pet.asAvatar();
    });

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
      SizedBox(
        height: 64,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: tiles.toList(),
          shrinkWrap: true,
        ),
      )
    ];

    return Container(
        decoration: BoxDecoration(borderRadius: radius, color: primaryColour),
        child: ListView(
          children: finalTiles,
          shrinkWrap: true,
        ));
  }
}
