import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'MyPage.dart';
import 'SubmitScreen.dart';
import 'TargetScreen.dart';
import 'TargetAddPage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectIndex = 0;
  var _pages = <Widget>[];
  //var _label = '';
  var _titles = ['メイン', '目標設定', '成績提出', '設定'];
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text('$nameさんは$dateStringに'),
            Container(
                height: 125,
                child: ListView.builder(
                    itemCount: lessonList.length,
                    itemBuilder: (context, index) {
                      String i = index.toString();
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(i),
                            Text(":"),
                            Text(lessonList[index])
                          ]);
                    })),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: _titles[0],
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: _titles[1],
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: _titles[2],
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: _titles[3],
            backgroundColor: Colors.blue,
          ),
        ],
        currentIndex: _selectIndex,
        //onTap: _onTapItem,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushNamed("/home");
              break;
            case 1:
              Navigator.of(context).pushNamed("/target");
              break;
            case 2:
              Navigator.of(context).pushNamed("/submit");
              break;
            case 3:
              Navigator.of(context).pushNamed("/setting");
              break;
          }
        },
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
