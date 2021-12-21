import 'package:flutter/material.dart';
import 'package:tanimy/pages/HomeScreen.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "tani_money",
      home: HomeScreen(),
    );
  }
}
