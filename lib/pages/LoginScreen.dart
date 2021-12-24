import 'package:flutter/material.dart';
import 'package:tanimy/models/botton_common.dart';

import 'MainScreen.dart';
import 'SignUpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _passwordFocusNode = FocusNode();

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ログイン"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(children: [
            SizedBox(height: 200),

            //メールアドレス入力フォーム
            _buildInputField(
              textInputType: TextInputType.emailAddress,
              controller: emailController,
              hintText: "メールアドレス",
              validator: (value) {
                if (value!.isEmpty) {
                  return ("メールアドレスを入力してください");
                }
                if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                    .hasMatch(value)) {
                  return ("正しいメールアドレスを入力してください");
                }
              },
              icon: Icons.email,
              obscureText: false,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 45),

            //パスワード入力フォーム
            _buildInputField(
              textInputType: TextInputType.visiblePassword,
              controller: passwordController,
              hintText: "パスワード",
              validator: (value) {
                RegExp regex = new RegExp(r'^.{8,}$');
                if (value!.isEmpty) {
                  return ("パスワードを入力してください");
                }
                if (!regex.hasMatch(value)) {
                  return ("パスワードは８文字以上です");
                }
              },
              icon: Icons.vpn_key_outlined,
              obscureText: true,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 45),
            ButtonCommon(
                onPressed: () {
                  signIn(emailController.text, passwordController.text);
                },
                label: "ログイン",
                color: Colors.blue),
            SizedBox(
              height: 15.0,
            ),

            TextButton(
              child: const Text('初めての方はこちら',style: TextStyle(fontSize: 16.0,fontFamily: "Mont"),),
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
              onPressed: () => startSignupScreen(context),
            ),
          ]),
        ),
      ), //userlist画面へ移動
    );
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) =>
      {
        Fluttertoast.showToast(msg: "ログイン"),
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MainScreen())),
      })
          .catchError((e) {
        Fluttertoast.showToast(msg: "メールアドレス、パスワードが正しくありません");
      });
    }
  }

  Widget _buildInputField({required TextEditingController controller,
    required TextInputType textInputType,
    required String hintText,
    required IconData icon,
    required bool obscureText,
    required TextInputAction textInputAction,
    FormFieldValidator? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0),
      child: TextFormField(
        autofocus: false,
        controller: controller,
        keyboardType: textInputType,
        obscureText: obscureText,
        textInputAction: TextInputAction.next,
        validator: validator,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: hintText,
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      ),
    );
  }

  startSignupScreen(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }
}