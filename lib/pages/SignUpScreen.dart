import 'package:flutter/material.dart';

import 'LoginScreen.dart';
import 'MainScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新規登録"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Center(child: ElevatedButton(onPressed: ()=> startMainScreen(context), child: Text("新規登録"))),
          Center(child: ElevatedButton(onPressed: ()=> startLoginScreen(context), child: Text("ログインする"))),
        ],
      ),
    );
  }
  startMainScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
  }
  startLoginScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}

