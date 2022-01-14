import 'package:flutter/material.dart';
import 'package:tanimy/pages/TargetAddPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

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
                              trailing:Text(data["targetOfSubject"] != null?data["targetOfSubject"]:" "),
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
        child: FloatingActionButton.extended(
          onPressed: () async {
            // "push"で新規画面に遷移
            // リスト追加画面から渡さSれる値を受け取る
            final newListText = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                // 遷移先の画面としてリスト追加画面を指定
                return TargetAddPage();
              }),
            );
          },
            icon: new Icon(Icons.add),
            label: Text("単位を追加する",
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center)
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
