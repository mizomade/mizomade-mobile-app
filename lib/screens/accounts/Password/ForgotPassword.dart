import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mizomade/screens/accounts/Password/OTPPassword.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mizomade/utils/Network.dart';

import '../../../utils/CustomUtils.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _phonenumber = TextEditingController();
  bool loading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                "Forgot password ?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Enter mobile number linked with your account"),
              SizedBox(
                height: 20,
              ),
              IntlPhoneField(
                // controller: _phonenumber,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'IN',
                onChanged: (phone) {
                  print(phone.completeNumber);
                  // setState(() {
                  _phonenumber.text = phone.completeNumber;
                  // });
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: () async {
                    Future.delayed(const Duration(milliseconds: 500), () {
                      setState(() {
                        loading = true;
                      });
                    });

                    try {
                      Timer(Duration(seconds: 1), () async {
                        var result =
                            await phonePasswordForget(_phonenumber.text);
                        print("Results");
                        print(result);
                        if (result == true) {
                          loading = false;

                          CustomUtils.successSnackBar(
                              context, "Otp Sent to Mobile number.");

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OTPPassword()));
                        } else if (result == false) {
                          setState(() {
                            loading = false;
                          });
                          CustomUtils.errorSnackbar(
                              context, "No account linked to phone number");
                        }
                      });

                      // print("PHONENUMBER" + _phonenumber.text);
                      // // setState(() {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => OTPPassword()));

                      // });
                    } finally {
                      Future.delayed(const Duration(milliseconds: 15000), () {
                        setState(() {
                          loading = false;
                        });
                        CustomUtils.infoSnackBar(
                            context, " Connection timeout!");
                      });
                    }
                  },
                  child: Text(
                    "SEND OTP",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
