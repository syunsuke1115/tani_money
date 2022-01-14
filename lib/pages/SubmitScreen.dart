import 'package:flutter/material.dart';

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({Key? key}) : super(key: key);

  @override
  _SubmitScreenState createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {

  bool _active = false;

  void _changeSwitch(bool e) => setState(() => _active = e);

  final List<List<String>> seiseki = [
    ["科目名1", "1000"],
    ["科目名2", "1000"],
    ["科目名3", "1000"],
  ];
  int _price = 0;
  int _credit = 0;


  // 選択された要素のインデックスを保管する
  final List<int> _selectedIndex = [];

  void _handleCheckbox(int index, bool e) {
    setState(() {
      // 選択が解除されたらリストから消す
      if (_selectedIndex.contains(index)) {
        _selectedIndex.remove(index);
      } else {
        // 選択されたらリストに追加する
        _selectedIndex.add(index);
      }
      if (_selectedIndex.isEmpty) {
        // 何も選択されていないときは合計値は0円 単位も0単位
        _price = 0;
        _credit = 0;
        return;
      }
      _price = _selectedIndex
          .map((i) => seiseki[i][1]) // seisekiから値段を抽出
          .map(int.parse) // 数値に変換
          .reduce((value, element) => value + element); // 合計値を計算
      _credit = _selectedIndex.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("成績提出"),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: CheckboxListTile(
                activeColor: Colors.orange,
                title: Text(seiseki[index][0]),
                secondary: Text("+${seiseki[index][1]}円"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _selectedIndex.contains(index),
                onChanged: (e) {
                  // Card 内のチェックボックスが選択されたら実行
                  _handleCheckbox(index, e!);
                },
              ),
            );
          },
          itemCount: seiseki.length,
        ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()async {
          if(_selectedIndex.isEmpty){
            var result = await showDialog<int>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('成績'),
                  content: Center(
                      child: Image.asset('images/congrat.png'),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('OK'),
                      onPressed: () => Navigator.of(context).pop(1),
                    ),
                  ],
                );
              },
            );
            print('dialog result: $result');
          } else{
          // ダイアログを表示------------------------------------
          var result = await showDialog<int>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('成績'),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("あなたの落とした単位は"),
                    Text("$_credit"),
                    Text("金額は"),
                    Text("$_price"),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop(1),
                  ),
                ],
              );
            },
          );
          print('dialog result: $result');
          // --
          }
        },
        icon: new Icon(Icons.add),
        label: Text("成績を提出する"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
      ),


    );

  }}


