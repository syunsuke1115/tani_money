import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({Key? key}) : super(key: key);

  @override
  _SubmitScreenState createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {

  bool _active = false;

  void _changeSwitch(bool e) => setState(() => _active = e);
  late List<String> seiseki = [];
  late var fine = 0;

  void getMessagesFine() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    final messages = await FirebaseFirestore.instance.collection("users").doc(uid)
        .collection('targets').get();
    final userData = await FirebaseFirestore.instance.collection("users").doc(uid).get();
    fine = userData.data()!["fine"];
    for (var message in messages.docs) {
      seiseki.add(message.data()["subjectName"]);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getMessagesFine();
    super.initState();
  }

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
          .map((i) => fine) // seisekiから値段を抽出
          .reduce((value, element) => value + element); // 合計値を計算
      _credit = _selectedIndex.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("成績提出",
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: CheckboxListTile(
                activeColor: Colors.orange,
                title: Text(seiseki[index],
                    style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left
                ),
                secondary: Text("+${fine}円",
                    style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center
                ),
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
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 50.0),
        alignment: Alignment.bottomCenter,
       child:FloatingActionButton.extended(
        onPressed: ()async {
          if(_selectedIndex.isEmpty){
            var result = await showDialog<int>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  insetPadding: EdgeInsets.all(10),
                  content: Center(
                      child: Stack(
                        clipBehavior: Clip.none, alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.deepOrange
                            ),
                            padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                            child: Align(
                              alignment: Alignment(0, 0),
                              child: Text("単位を全て取得できました!",
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center

                              ),
                            ),
                          ),
                          Positioned(
                              top: -100,
                              child: Image.asset("images/congrat.png", width: 150, height: 150)
                          )
                        ],
                      )
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text('OK',
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrangeAccent,
                        onPrimary: Colors.black,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: ()=> Navigator.of(context).pop(1),
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
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.all(10),
                content: Center(
                    child: Stack(
                      clipBehavior: Clip.none, alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.deepPurple
                          ),
                          padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                          child: Align(
                            alignment: Alignment(0, 0),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("あなたの落とした単位は",
                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,color: Colors.grey,decoration: TextDecoration.underline),
                                    textAlign: TextAlign.center
                          ),
                                Text("$_credit単位",
                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center
                                ),
                                Text("金額は",
                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,color: Colors.grey,decoration: TextDecoration.underline),
                                    textAlign: TextAlign.center
                                ),
                                Text("$_price円",
                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            top: -100,
                            child: Image.asset("images/sad.png", width: 150, height: 150)
                        )
                      ],
                    )
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('OK',
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      onPrimary: Colors.black,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: ()=> Navigator.of(context).pop(1),
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
        label: Text("成績を提出する",
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
      ),




     ),
    );

  }}


