
import 'package:flutter/material.dart';

import 'MyPage.dart';
import 'SubmitScreen.dart';
import 'TargetScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("メインスクリーン"),//TODO メインスクリーンと言わない
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Center(child: ElevatedButton(onPressed: ()=> startTargetScreen(context), child: Text("目標を設定する"))),
              Center(child: ElevatedButton(onPressed: ()=> startSubmitScreen(context), child: Text("成績を提出する"))),
              Center(child: ElevatedButton(onPressed: ()=> startMyPage(context), child: Text("マイページ"))),
            ],
          ),
        )
    );
  }
  startTargetScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => TargetScreen()));
  }
  startSubmitScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitScreen()));
  }
  startMyPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyPage()));
  }
}
