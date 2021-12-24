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
        child: Center(
        child: Column(
        children: [
        SizedBox(
        height: 50,
    ),
    Text(
    "Tani money",
    style: TextStyle(
    fontSize: 45,
    color: Colors.blue,
    fontWeight: FontWeight.bold,
    ),
    ),
    SizedBox(
    height: 30,
    ),
    Text(
    "あなたの覚悟に値段はつけられますか？",
    style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    ),
    ),
    SizedBox(
    height: 18,
    ),
    Text(
    "これでもう単位を落とすことはありません",
    style: TextStyle(
    fontSize: 15,
    ),
    ),
    SizedBox(
    height: 10,
    ),
    Text(
    "充実した大学生活を送りましょう",
    style: TextStyle(
    fontSize: 15,
    ),
    ),
    SizedBox(
    height: 10,
    ),
    ElevatedButton(
    onPressed: () => startLogin(context), child: Text("ログイン")),
    SizedBox(
    height: 10,
    ),
    ElevatedButton(
    onPressed: () => startSignUp(context), child: Text("新規登録")),
    SizedBox(
    height: 15,
    ),
    Text(
    "※このアプリは自分が落とさないと決意した単位に対して課金するアプリです",
    style: TextStyle(fontSize: 9),
    )
    ],
    ),
    ),
    ));
  }
  startLogin(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  startSignUp(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

}
