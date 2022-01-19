import 'package:flutter/material.dart';

class ScrollableList extends StatefulWidget {
  @override
  _ScrollableListState createState() => _ScrollableListState();
}

class _ScrollableListState extends State<ScrollableList> {
  late ScrollController _scrollController;

  bool _onNotification(t) {
    if (t is ScrollEndNotification) {
      print("test");
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        minChildSize: 0.15,
        initialChildSize: 1,
        builder: (BuildContext context, ScrollController scrollController) {
          const Radius borderRadius = Radius.circular(35);
          _scrollController = scrollController;
          return Container(
              decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: const BorderRadius.only(
                      topLeft: borderRadius, topRight: borderRadius)),
              child: NotificationListener(
                  onNotification: _onNotification,
                  child: ListView.builder(
                      controller: scrollController,
                      itemCount: 25,
                      itemBuilder: (BuildContext context, int item) {
                        if (item == 0) {
                          return const Icon(Icons.horizontal_rule_rounded);
                        }
                        if (item.isOdd) return const Divider();

                        final int index = (item) ~/ 2;

                        return ListTile(
                          title: Text(' Item $index'),
                        );
                      })));
        });
  }
}
