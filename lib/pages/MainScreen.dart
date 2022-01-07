import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';

import 'MyPage.dart';
import 'SubmitScreen.dart';
import 'TargetScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectIndex = 0;
  var _pages = <Widget>[];

  //var _label = '';
  var _titles = ['目標設定', '成績提出', '設定'];
  String name = "hogehoge";
  static DateTime setDate = DateTime(2021, 12, 24, 14, 28);
  static DateFormat outputFormat = DateFormat('yyyy年MM月dd日');
  String dateString = outputFormat.format(setDate);
  List<String> lessonList = ["プログラミング基礎", "安全学基礎", "システム創成学基礎"];

  void _onPageChanged(int index) {
    setState(() {
      _selectIndex = index;
    });
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

    return Scaffold(
      appBar: AppBar(
        //title: Text("メインスクリーン"), //TODO メインスクリーンと言わない
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _targetsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
                return Expanded(
                  child: ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return Card(
                          child: ListTile(
                        title: Text(data["subjectName"]),
                      ));
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            title: Text(_titles[0]),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text(_titles[1]),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text(_titles[2]),
          ),
        ],
        onTap: (int index) {
          _selectIndex = index;
          //_label = _titles[index];
        },
        currentIndex: _selectIndex,
      ),
    );
  }

  startTargetScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TargetScreen()));
  }

  startSubmitScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SubmitScreen()));
  }

  startMyPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyPage()));
  }
}
