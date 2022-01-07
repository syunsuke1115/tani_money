import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'TargetAddPage.dart';

class TargetScreen extends StatefulWidget {
  @override
  _TargetScreenState createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  List<DropdownMenuItem<int>> _items = [];
  int _selectItem = 0;

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

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    final Stream<QuerySnapshot> _targetsStream = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection("targets")
        .snapshots();
    List<String> targetList = [];

    return Scaffold(
      // AppBarを表示し、タイトルも設定
      appBar: AppBar(
        title: Text('リスト一覧'),
      ),
      // データを元にListViewを作成
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
                          trailing: DropdownButton(
                            items: _items,
                            value: _selectItem,
                            onChanged: (int? value) => {
                              setState(() {
                                _selectItem = value!;
                              }),
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        child: FloatingActionButton(
          onPressed: () async {
            // "push"で新規画面に遷移
            // リスト追加画面から渡される値を受け取る
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
}
