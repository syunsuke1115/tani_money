import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tanimy/models/botton_common.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tanimy/parts/use_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'LoginScreen.dart';
import 'MainScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final nicknameController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final confirmPasswordController = new TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("新規登録"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 150),

                //nickNameField
                _buildInputField(
                    controller: nicknameController,
                    textInputType: TextInputType.name,
                    hintText: "ニックネーム",
                    obscureText: false,
                    onSaved: (value) {
                      nicknameController.text = value!;
                    },
                    icon: Icons.account_circle,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      RegExp regex = new RegExp(r'^.{1,10}$');
                      if (value!.isEmpty) {
                        return ("ニックネームを入力してください");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("ニックネームは1文字以上10文字以内です");
                      }
                    }),

                SizedBox(height: 30),

                //emailField
                _buildInputField(
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    hintText: "メールアドレス",
                    obscureText: false,
                    onSaved: (value) {
                      emailController.text = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("メールアドレスを入力してください");
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("正しいメールアドレスを入力してください");
                      }
                    },
                    icon: Icons.mail,
                    textInputAction: TextInputAction.next),

                SizedBox(height: 30),

                //PasswordField
                _buildInputField(
                    controller: passwordController,
                    textInputType: TextInputType.visiblePassword,
                    hintText: "パスワード",
                    obscureText: true,
                    onSaved: (value) {
                      passwordController.text = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("パスワードを入力してください");
                      }
                      if (!RegExp("^(?=.*?[a-zA-Z])(?=.*?[0-9])[a-zA-Z0-9]")
                          .hasMatch(value)) {
                        return ("半角英字数字をそれぞれ入れてください");
                      }
                      if (value.length < 8) {
                        return ("8文字以上のパスワードにしてください");
                      }
                    },
                    icon: Icons.vpn_key,
                    textInputAction: TextInputAction.next),

                SizedBox(height: 30),

                //ConfirmPasswordField
                _buildInputField(
                    controller: confirmPasswordController,
                    textInputType: TextInputType.visiblePassword,
                    hintText: "パスワード（再）",
                    obscureText: true,
                    onSaved: (value) {
                      confirmPasswordController.text = value!;
                    },
                    validator: (value) {
                      if (confirmPasswordController.text !=
                          passwordController.text) {
                        return ("パスワードが一致しません");
                      }
                    },
                    icon: Icons.vpn_key,
                    textInputAction: TextInputAction.done),

                SizedBox(height: 30),
                //userlist画面へ移動
                ButtonCommon(
                    onPressed: () =>
                        signUp(emailController.text, passwordController.text),
                    label: "登録",
                    color: Colors.blue),

                //loginscreenへ移動
                SizedBox(
                  height: 15.0,
                ),
                TextButton(
                  child: const Text(
                    '既にアカウントをお持ちの方はこちら',
                    style: TextStyle(fontSize: 16.0, fontFamily: "Mont"),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: () => startLoginScreen(context),
                ),
              ],
            ),
          ),
        ));
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  Widget _buildInputField(
      {required TextEditingController controller,
      required TextInputType textInputType,
      required String hintText,
      required FormFieldSetter onSaved,
      required IconData icon,
      required bool obscureText,
      required TextInputAction textInputAction,
      required FormFieldValidator validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0),
      child: TextFormField(
        autofocus: false,
        controller: controller,
        keyboardType: textInputType,
        onSaved: onSaved,
        validator: validator,
        obscureText: obscureText,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: hintText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      ),
    );
  }

  startLoginScreen(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.nickname = nicknameController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => MainScreen()),
        (route) => false);
  }
}
