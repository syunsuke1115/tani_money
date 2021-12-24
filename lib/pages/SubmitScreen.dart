import 'package:flutter/material.dart';

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({Key? key}) : super(key: key);

  @override
  _SubmitScreenState createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("成績提出"),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Container(
            alignment: Alignment.center,
            child:SizedBox(
              height: 150, // Widgetの高さを指定
              width: 150,
              child:ElevatedButton(
                child: const Text('成績表pdfを提出'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  shape: const CircleBorder(
                    side: BorderSide(
                      color: Colors.black,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                onPressed: () {},
              ),

            )
        )
          );
  }}
