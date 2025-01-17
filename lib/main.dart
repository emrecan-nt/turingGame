import 'package:flutter/material.dart';
import 'package:turing_game/UsernameScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Turing  Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UsernameScreen(),
    );
  }
}

