import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';

import 'MyPage.dart';
import 'SubmitScreen.dart';
import 'TargetScreen.dart';

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
    return Scaffold(
      appBar: AppBar(
        //title: Text("メインスクリーン"), //TODO メインスクリーンと言わない
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
            Center(
                child: ElevatedButton(
                    onPressed: () => startTargetScreen(context),
                    child: Text("目標を設定する"))),
            Center(
                child: ElevatedButton(
                    onPressed: () => startSubmitScreen(context),
                    child: Text("成績を提出する"))),
            Center(
                child: ElevatedButton(
                    onPressed: () => startMyPage(context),
                    child: Text("マイページ"))),
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
