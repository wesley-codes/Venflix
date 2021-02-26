import 'package:flutter/material.dart';
import 'package:venflix/Screens/MovieScreen.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MovieScreen(),
    );
  }
}
