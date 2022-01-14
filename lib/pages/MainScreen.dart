import 'package:flutter/material.dart';
import 'package:tanimy/pages/TargetAddPage.dart';
import 'package:tanimy/parts/use_model.dart';

import 'SettingScreen.dart';
import 'SubmitScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<DropdownMenuItem<int>> _items = [];
  int _selectItem = 0;
  List<String> targetList = [];
  String name = "hogehoge";
  static DateTime setDate = DateTime(2021, 12, 24, 14, 28);
  static DateFormat outputFormat = DateFormat('yyyy年MM月dd日');
  String dateString = outputFormat.format(setDate);
  List<String> lessonList = ["プログラミング基礎", "安全学基礎", "システム創成学基礎"];

  @override
  void initState() {
    super.initState();
    setItems();
    _selectItem = _items[0].value!;
  }

  void setItems() {
    _items
      ..add(DropdownMenuItem(
        child: Text(
          '得単',
          style: TextStyle(fontSize: 20.0),
        ),
        value: 1,
      ))
      ..add(DropdownMenuItem(
        child: Text(
          '優',
          style: TextStyle(fontSize: 20.0),
        ),
        value: 2,
      ))
      ..add(DropdownMenuItem(
        child: Text(
          '優上',
          style: TextStyle(fontSize: 20.0),
        ),
        value: 3,
      ));
  }

  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    final Stream<QuerySnapshot> _targetsStream = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection("targets")
        .snapshots();

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text("目標単位"),
      ),
      body: Container(
        child: FutureBuilder<DocumentSnapshot>(
            future: users.doc(uid).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Column(
                children: [
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      homeMessage(data),
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  MoneyMessage(data),
                  SizedBox(height: 20),
                  StreamBuilder<QuerySnapshot>(
                    stream: _targetsStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Expanded(
                        child: ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            return Card(
                                child: ListTile(
                              title: Text(data["subjectName"]),
                              trailing: Text(data["targetOfSubject"]),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ],
              );
            }),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          onPressed: () async {
            // "push"で新規画面に遷移
            // リスト追加画面から渡さSれる値を受け取る
            final newListText = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                // 遷移先の画面としてリスト追加画面を指定
                return TargetAddPage();
              }),
            );
            if (newListText != null) {
              // キャンセルした場合は newListText が null となるので注意
              setState(() {
                // リスト追加
                targetList.add(newListText);
              });
            }
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  String homeMessage(Map<String, dynamic> data) {
    String message = "";
    if (data["targetFrag"] == true) {
      message = "${data["nickname"]}さんは以下の目標を設定しました\n           諦めずにがんばりましょう";
    } else {
      message = "右下のプラスボタンから\n目標を追加してください";
    }
    return message;
  }

  Widget MoneyMessage(Map<String, dynamic> data) {
    if (data["targetFrag"] == true) {
      int fine = 100;
      if (data["fine"] != null) {
        fine = data["fine"];
      }
      return Column(children: [
        SizedBox(height: 10),
        Center(
          child: RichText(text: TextSpan(
            children: [
              TextSpan(text: "1単位落とすと",style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),),
              TextSpan(text: fine.toString(), style: TextStyle(
                fontSize: 24,
                  color:Colors.red,
                  fontWeight: FontWeight.bold,
              ),),
              TextSpan(text: "円課金されます",style: TextStyle(
                fontSize: 18,
                  color: Colors.black
              ),),
            ],),
          ),
        ),
      ]);
    } else {
      return SizedBox(height: 1);
    }
  }
}
