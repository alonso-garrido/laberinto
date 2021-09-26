import 'package:flutter/material.dart';
import './maze_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LABERINTO',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: MazePage(),
    );
  }
}