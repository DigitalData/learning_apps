import 'package:flutter/material.dart';
// import 'package:flutter_config/flutter_config.dart';

import 'map-screen/map_screen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  // await FlutterConfig.loadEnvVariables();

  runApp(const MapApp());
}

class MapApp extends StatelessWidget {
  const MapApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MapScreen());
  }
}

// class MyApp extends StatefulWidget {
//   // If a key exists then use it.
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late GoogleMapController mapController;
//   late Marker reticle;
//   final MarkerId reticleID = const MarkerId("reticle");

//   // position on the map.
//   LatLng _currentPosition = const LatLng(-35.3035, 149.1227);

//   final Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;

//     setState(() {
//       reticle = Marker(
//           markerId: reticleID,
//           position: _currentPosition,
//           icon:
//               BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure));
//       markers[reticleID] = reticle;
//     });
//   }

//   void _travel() {
//     mapController.animateCamera(CameraUpdate.newLatLng(_randomLatLng()));
//   }

//   void _saveCurrentLocation() {
//     final id = MarkerId(markers.length.toString());
//     final pos = _currentPosition;
//     final newMarker = Marker(
//         markerId: id,
//         position: pos,
//         infoWindow: InfoWindow(
//             title: id.toString(), snippet: id.toString() + "th marker"));

//     setState(() {
//       markers[id] = newMarker;
//     });
//   }

//   void _onCameraMove(CameraPosition pos) {
//     setState(() {
//       _currentPosition = pos.target;
//       reticle = Marker(
//           markerId: reticleID,
//           position: _currentPosition,
//           icon:
//               BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure));
//       markers[reticleID] = reticle;
//     });
//   }

//   LatLng _randomLatLng() {
//     final randomGen = Random.secure();

//     const List<double> bounds = [
//       113.338953078,
//       -43.6345972634,
//       153.569469029,
//       -10.6681857235
//     ];

//     double lat = (bounds[3] - bounds[1]) * randomGen.nextDouble() + bounds[1];
//     double lng = (bounds[2] - bounds[0]) * randomGen.nextDouble() + bounds[0];
//     return LatLng(lat, lng);
//   }

//   void _openDrawer() {}

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//             appBar: AppBar(
//               title: const Text("Map Sample App"),
//               backgroundColor: primaryColour,
//               actions: <Widget>[
//                 IconButton(onPressed: _travel, icon: const Icon(Icons.flight))
//               ],
//             ),
//             body: Stack(children: <Widget>[
//               GoogleMap(
//                 padding: const EdgeInsets.only(bottom: 70, right: 12.5),
//                 onMapCreated: _onMapCreated,
//                 onCameraMove: _onCameraMove,
//                 markers: markers.values.toSet(),
//                 initialCameraPosition:
//                     CameraPosition(target: _currentPosition, zoom: 11.0),
//               ),
//               Align(
//                 alignment: Alignment.bottomLeft,
//                 child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: FloatingActionButton(
//                         child: const Icon(Icons.open_in_browser),
//                         backgroundColor: primaryColour,
//                         onPressed: _openDrawer)),
//               ),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: FloatingActionButton(
//                         child: const Icon(Icons.save),
//                         backgroundColor: primaryColour,
//                         onPressed: _saveCurrentLocation)),
//               )
//             ]),
//             bottomNavigationBar: Stack(children: <Widget>[
//               BottomNavigationBar(items: const [
//                 BottomNavigationBarItem(
//                     label: "Text(uh)", icon: Icon(Icons.ac_unit)),
//                 BottomNavigationBarItem(
//                     label: "Text(uh)", icon: Icon(Icons.ac_unit))
//               ])
//             ])));
//   }
// }



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
