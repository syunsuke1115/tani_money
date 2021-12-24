import 'package:flutter/material.dart';

import 'MainScreen.dart';
import 'SignUpScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ログイン"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(child: ElevatedButton(onPressed: ()=> startMainScreen(context), child: Text("ログイン"))),
            Center(child: ElevatedButton(onPressed: ()=> startSignUp(context), child: Text("アカウント持ってない"))),
          ],
        ),
      )
    );
  }

  startMainScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
  }
  startSignUp(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }
}
