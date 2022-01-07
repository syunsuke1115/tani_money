import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tanimy/pages/MainScreen.dart';
import 'package:tanimy/pages/MyPage.dart';
import 'package:tanimy/pages/SubmitScreen.dart';
import 'pages/HomeScreen.dart';

void main() async {
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
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new MainScreen(),
        '/submit': (BuildContext context) => new SubmitScreen(),
        '/setting': (BuildContext context) => new MyPage()
      },
    );
  }
}
