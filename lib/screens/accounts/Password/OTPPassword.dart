import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mizomade/screens/accounts/Password/NewPasswordForgot.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPPassword extends StatefulWidget {
  const OTPPassword({Key key}) : super(key: key);

  @override
  _OTPPasswordState createState() => _OTPPasswordState();
}

class _OTPPasswordState extends State<OTPPassword> {
  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
      ),
      body: Container(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                "Enter OTP",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      showCursor: false,
                      appContext: context,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      pastedTextStyle: TextStyle(
                        color: Colors.deepPurple.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      obscureText: true,
                      obscuringCharacter: '*',
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v.length < 3) {
                          return "Enter six digit OTP";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        inactiveFillColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        selectedColor: Colors.deepPurple.shade600,
                        activeColor: Colors.deepPurple.shade200,
                        selectedFillColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        inactiveColor: Colors.black38,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor:
                            Theme.of(context).scaffoldBackgroundColor,
                      ),
                      cursorColor: Colors.white,
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Theme.of(context).primaryColor,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        print("Completed");
                      },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              SizedBox(
                height: 0,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewPasswordForgot()));
                  },
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              TextButton(
                  style: TextButton.styleFrom(primary: Colors.deepPurple),
                  onPressed: () {},
                  child: Text("Resend OTP")),
            ],
          ),
        ),
      ),
    );
  }
}
