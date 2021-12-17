import 'package:flutter/material.dart';

class TargetScreen extends StatefulWidget {
  const TargetScreen({Key? key}) : super(key: key);

  @override
  _TargetScreenState createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("目標を設定"),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Container());
  }
}
