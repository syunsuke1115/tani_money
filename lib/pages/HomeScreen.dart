import 'package:flutter/material.dart';

import 'LoginScreen.dart';
import 'SignUpScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SizedBox(height: 30),
          Text(
            "Test",
            style: TextStyle(fontSize: 40),
          ),
          Text("説明文 このアプリは課金アプリです．", style: TextStyle(fontSize: 20)),
          ElevatedButton(
              onPressed: () => startLogin(context), child: Text("ログイン")),
          ElevatedButton(
              onPressed: () => startSignUp(context), child: Text("新規登録"))
        ],
      ),
    ));
  }
}

startLogin(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => LoginScreen()));
}

startSignUp(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SignUpScreen()));
}
