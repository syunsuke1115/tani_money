import 'package:flutter/material.dart';
import 'package:tanimy/models/botton_common.dart';

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
      body: SingleChildScrollView(
        child: SafeArea(
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
                  "単位を落としたら課金されるアプリです",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 10,
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
                Container(height: 300, child: Image.asset("images/title.png")),
                ButtonCommon(
                    onPressed: () => startLogin(context),
                    label: "ログイン",
                    color: Colors.blue),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  child: const Text(
                    '新規登録',
                    style: TextStyle(fontSize: 16.0, fontFamily: "Mont"),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: () => startSignUp(context),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  startLogin(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  startSignUp(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }
}
