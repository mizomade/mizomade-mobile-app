import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mizomade/screens/pages/MainPage.dart';
import 'package:mizomade/utils/Network.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../utils/CustomUtils.dart';
import '../../utils/States.dart';

class OTPRegister extends StatefulWidget {
  const OTPRegister({Key key}) : super(key: key);

  @override
  _OTPRegisterState createState() => _OTPRegisterState();
}

class _OTPRegisterState extends State<OTPRegister> {
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),

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
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                  ),
                  onPressed: () async {
                    var result =
                        await otpVerification(textEditingController.text);
                    print("Results");
                    print(result);
                    if (result == true) {
                      Provider.of<Profile>(context, listen: false)
                          .setAuthenticated = true;
                      CustomUtils.successSnackBar(
                          context, "Registration Successfull");

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MainPage()));
                    } else {
                      CustomUtils.errorSnackbar(
                          context, "Incorrect Credentials");
                    }
                  },
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text("Resend OTP",
                      style: TextStyle(color: Colors.deepPurple))),
            ],
          ),
        ),
      ),
    );
  }


  @override
  void dispose(){
    errorController.close();
    super.dispose();
  }
}
