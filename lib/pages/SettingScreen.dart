import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tanimy/models/botton_common.dart';
import 'package:tanimy/pages/CreditRegisterScreen.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

void main() {
  runApp(new SettingScreen());
}

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController amountController = new TextEditingController();

  Token? _paymentToken;
  PaymentMethod? _paymentMethod;
  String? _error;

  //this client secret is typically created by a backend system
  //check https://stripe.com/docs/payments/payment-intents#passing-to-client
  final String? _paymentIntentClientSecret = null;

  PaymentIntentResult? _paymentIntent;
  Source? _source;

  ScrollController _controller = ScrollController();

  final CreditCard testCard = CreditCard(
    number: '4000002760003184',
    expMonth: 12,
    expYear: 21,
    name: 'Test User',
    cvc: '133',
    addressLine1: 'Address 1',
    addressLine2: 'Address 2',
    addressCity: 'City',
    addressState: 'JP',
    addressZip: '1337',
  );

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  initState() {
    super.initState();

    StripePayment.setOptions(StripeOptions(
        publishableKey: "pk_test_aSaULNS8cJU6Tvo20VAXy6rp",
        merchantId: "Test",
        androidPayMode: 'test'));
  }

  void setError(dynamic error) {
    _scaffoldKey.currentState!
        .showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("設定"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  _source = null;
                  _paymentIntent = null;
                  _paymentMethod = null;
                  _paymentToken = null;
                });
              },
            )
          ],
        ),
        body: ListView(
          controller: _controller,
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            Column(
              children: [
                _buildInputField(
                  textInputType: TextInputType.emailAddress,
                  controller: amountController,
                  hintText: "金額[円]を入力してください",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("金額[円]を入力してください");
                    }
                    if (true) {
                      return ("整数を入力してください");
                    }
                  },
                  icon: Icons.money_outlined,
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 15.0,
                ),
                ButtonCommon(
                    onPressed: () {
                      ////////金額の変数//////
                      ///
                      ///
                      final billingAmount = TextEditingController().text;
                      enterAmount(amountController.text);
                    },
                    label: "金額を確定",
                    color: Colors.blue),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Divider(),
            SizedBox(
              height: 15.0,
            ),
            ButtonCommon(
                onPressed: () {
                  StripePayment.paymentRequestWithCardForm(
                          CardFormPaymentRequest())
                      .then((paymentMethod) {
                    _scaffoldKey.currentState!.showSnackBar(SnackBar(
                        content: Text('Received ${paymentMethod.id}')));
                    setState(() {
                      _paymentMethod = paymentMethod;
                    });
                  }).catchError(setError);
                },
                label: "クレジットカードを追加",
                color: Colors.blue),
            SizedBox(
              height: 15.0,
            ),
            ButtonCommon(
                onPressed: () {
                  if (Platform.isIOS) {
                    _controller.jumpTo(450);
                  }
                  StripePayment.paymentRequestWithNativePay(
                    androidPayOptions: AndroidPayPaymentRequest(
                      totalPrice: "1.20",
                      currencyCode: "JPY",
                    ),
                    applePayOptions: ApplePayPaymentOptions(
                      countryCode: 'JP',
                      currencyCode: 'JPY',
                      items: [
                        ApplePayItem(
                          label: 'Test',
                          amount: '13',
                        )
                      ],
                    ),
                  ).then((token) {
                    setState(() {
                      _scaffoldKey.currentState!.showSnackBar(
                          SnackBar(content: Text('Received ${token.tokenId}')));
                      _paymentToken = token;
                    });
                  }).catchError(setError);
                },
                label: "GooglePayを追加",
                color: Colors.blue),
          ],
        ),
      ),
    );
  }

  void enterAmount(String amount) async {
    final amountError = _formKey.currentState!.validate();
  }

  Widget _buildInputField(
      {required TextEditingController controller,
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
        keyboardType: TextInputType.number,
        obscureText: obscureText,
        textInputAction: TextInputAction.next,
        validator: validator,
        decoration: InputDecoration(
            labelText: "1単位落とした時の課金額",
            prefixIcon: Icon(icon),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: hintText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      ),
    );
  }
}
