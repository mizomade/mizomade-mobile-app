import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mizomade/screens/accounts/Password/ForgotPassword.dart';
import 'package:mizomade/screens/pages/MainPage.dart';
import 'package:http/http.dart' as http;
import 'package:mizomade/utils/API.dart';
import 'package:mizomade/utils/CustomUtils.dart';
import 'package:mizomade/utils/Network.dart';
import 'package:mizomade/utils/States.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool visible = false;
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  String logo = 'assets/signature/mlogo.png';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // FlutterLogo(size: 160,),
              //   Container(
              //     child: SvgPicture.asset(
              // 'assets/signature/mlogom.svg',
              //         semanticsLabel: 'My LOGO'
              //
              //     ),
              // //
              //   ),
              SizedBox(
                height: 80,
              ),
              Center(
                  child: Image.asset(
                logo,
                height: 100,
                width: 100,
              )),
              SizedBox(height: 50,),

              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Login",
                      style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          ))),
              SizedBox(
                height: 10,
              ),
              Flex(
                direction: Axis.vertical,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      controller: _username,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.person_outlined,
                        ),
                        border: OutlineInputBorder(),
                        labelText: "Username",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      controller: _password,
                      obscureText: !visible,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: visible
                                ? Icon(Icons.visibility_outlined)
                                : Icon(
                                    Icons.visibility_off_outlined,
                                  ),
                            onPressed: () {
                              setState(() {
                                visible = !visible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(),
                          labelText: "Password"),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgotPassword()));
                            },
                            child: Text(
                              "Forgot password ?",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.deepPurple),
                            ))),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 60,
                    child: FloatingActionButton.extended(
                      onPressed: () async {
                        setState(() {
                          loading = true;

                        });
                        Timer(Duration(seconds: 1), () async {
                          var result = await attemptLogin(_username.text, _password.text);
                          print("Results");
                          print(result);
                          if (result == true) {

                            loading = false;
                            Provider.of<Profile>(context, listen: false)
                                .setAuthenticated = true;
                            CustomUtils.successSnackBar(
                                context, "Logged in Successfull");

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage()));
                          } else {
                            setState(() {
                              loading = false;

                            });
                            CustomUtils.errorSnackbar(
                                context, "Incorrect Credentials");
                          }
                        });




                      },
                      label: Flex(
                          direction: Axis.horizontal,
                          children:[
                        loading == true ? Row(
                          children: [SizedBox(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                            height: 18,width: 18,
                          ),
                            SizedBox(width: 10,),
                            Text("Logging in ..", )
                          ]
                        ) :Text("Login", ),

                         ]),
                      isExtended: true,
                      // icon: Icon(  Icons.login_outlined,),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),

              Divider(),

              Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.symmetric(horizontal: 1, vertical: 0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register1()));
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(color: Colors.deepPurple),
                            ))
                      ])),
            ],
          ),
        ),
      ),
    );
  }
}
