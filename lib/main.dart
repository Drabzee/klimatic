import 'package:flutter/material.dart';
import './screens/homePage.dart';

void main() => runApp(Klimatic());

class Klimatic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Klimatic',
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}