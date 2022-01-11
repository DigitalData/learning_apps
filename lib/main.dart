import 'package:flutter/material.dart';
import './random_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Test',
        theme: ThemeData(
            primaryColor: Colors.red[300],
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)),
        home: RandomWords());
  }
}
