import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tanimy/pages/CreditRegisterScreen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("設定"),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
            child: Column(children: [
          TextField(
            controller: myController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '1単位落とした時の課金額を入力してください[円]',
            ),
          ),
          RaisedButton(
            child: Text('確定'),
            onPressed: () {
              final billingAmount = myController.text;
            },
          ),
          TextButton(
              child: Text("クレジットカード設定"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreditRegisterScreen()));
              })
        ])));
  }
}
