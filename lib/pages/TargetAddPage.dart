import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TargetAddPage extends StatefulWidget {
  @override
  _TargetAddPageState createState() => _TargetAddPageState();
}

class _TargetAddPageState extends State<TargetAddPage> {
  // 入力されたテキストをデータとして持つ
  String _creditText = '';
  String _targetText = '';
  static final _firestore = FirebaseFirestore.instance;

  // データを元に表示するWidget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト追加'),
      ),
      body: Container(
        // 余白を付ける
        padding: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 入力されたテキストを表示
            const SizedBox(height: 8),
            // テキスト入力
            TextField(
              // 入力されたテキストの値を受け取る（valueが入力されたテキスト）
              onChanged: (String value) {
                // データが変更したことを知らせる（画面を更新する）
                setState(() {
                  // データを変更
                  _creditText = value;
                });
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.library_books_outlined),
                  contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "単位名",
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
            ),
            const SizedBox(height: 8),
            TextField(
              // 入力されたテキストの値を受け取る（valueが入力されたテキスト）
              onChanged: (String value) {
                // データが変更したことを知らせる（画面を更新する）
                setState(() {
                  // データを変更
                  _targetText = value;
                });
              },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.trending_up),
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "目標",
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)))
            ),
            const SizedBox(height: 8),
            Container(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // リスト追加ボタン
              child: ElevatedButton(
                child: const Text('目標設定'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[300],
                  onPrimary: Colors.blue,
                ),
                onPressed: () {
                  // "pop"で前の画面に戻る
                  // "pop"の引数から前の画面にデータを渡す
                  addFirestore(_creditText,_targetText);
                },
              ),
            ),
            const SizedBox(height: 8),
            Container(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // キャンセルボタン
              child: TextButton(
                // ボタンをクリックした時の処理
                onPressed: () {
                  // "pop"で前の画面に戻る
                  Navigator.of(context).pop();
                },
                child: Text('キャンセル'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addFirestore(_creditText,_targetText) {
    //TODO　null チェック
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    _firestore
        .collection('users')
        .doc(uid)
        .collection('targets')
        .doc()
        .set({
      'subjectName': _creditText,
      "targetOfSubject":_targetText,
    });
    _firestore
        .collection('users')
        .doc(uid)
        .update({
      'targetFrag': true,
    });

  }
}