import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/HomeScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Myapp());
}

class Myapp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "tani_money",
      home: HomeScreen(),
    );
  }
}

