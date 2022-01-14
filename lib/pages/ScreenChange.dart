import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'MainScreen.dart';
import 'SettingScreen.dart';
import 'SubmitScreen.dart';

class ScreenChange extends StatefulWidget {
  const ScreenChange({Key? key}) : super(key: key);

  @override
  _ScreenChangeState createState() => _ScreenChangeState();
}

class _ScreenChangeState extends State<ScreenChange> {
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'Submit',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
            backgroundColor: Colors.blue,
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(child: MainScreen());
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(child: SubmitScreen());
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(child: SettingScreen());
            });
          default:
            return const CupertinoTabView();
        }
      },
    );
  }
}
