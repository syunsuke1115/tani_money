import 'package:flutter/material.dart';

import 'TargetAddPage.dart';

class TargetScreen extends StatefulWidget {
  @override
  _TargetScreenState createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  // Todoリストのデータ
  List<String> targetList = [];
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
        child: Text('得単', style: TextStyle(fontSize: 10.0),),
        value: 1,
      ))
      ..add(DropdownMenuItem(
        child: Text('優', style: TextStyle(fontSize: 10.0),),
        value: 2,
      ))
      ..add(DropdownMenuItem(
        child: Text('優上', style: TextStyle(fontSize: 10.0),),
        value: 3,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBarを表示し、タイトルも設定
      appBar: AppBar(
        title: Text('目標一覧'),
      ),
      // データを元にListViewを作成
      body: ListView.builder(
        itemCount: targetList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(targetList[index]),
              trailing: DropdownButton(
                items: _items,
                value: _selectItem,
                onChanged: (int? value) => {
                  setState(() {
                    _selectItem =  value!;
                  }),
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
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
    );
  }
}

