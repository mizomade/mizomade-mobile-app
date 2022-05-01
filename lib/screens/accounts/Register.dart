import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mizomade/screens/accounts/OTPRegister.dart';

import '../../utils/CustomUtils.dart';

class Register1 extends StatefulWidget {
  const Register1({Key key}) : super(key: key);

  @override
  _Register1State createState() => _Register1State();
}

class _Register1State extends State<Register1> {
  bool visible = false;
  bool same = true;
  TextEditingController _username = TextEditingController();
  TextEditingController _phonenumber = TextEditingController();
  TextEditingController _password1 = TextEditingController();
  TextEditingController _password2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign up",
        ),
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Image.asset(
                'assets/signature/mlogo.png',
                height: 80,
                width: 80,
              )),
              SizedBox(
                height: 20,
              ),
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
              SizedBox(
                height: 10,
              ),
              same ? SizedBox() : Text("Password must match"),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: _password1,
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
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: _password2,
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
                      labelText: "Confirm Password"),
                  onChanged: (value) {
                    if (_password1 != _password2) {
                      setState(() {
                        same = false;
                      });
                    } else if (_password1 == _password2) {
                      setState(() {
                        same = true;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: IntlPhoneField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'IN',
                  onChanged: (phone) {
                    print(phone.completeNumber);
                    _phonenumber.text = phone.completeNumber;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60,
                child: FloatingActionButton.extended(
                  onPressed: () async {
                    print(_phonenumber.text);
                    bool result = true;
                    // var result = await register1(_username.text, _password1.text,_phonenumber.text) ;
                    print("Results");
                    print(result);
                    if (result == true) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OTPRegister()));
                    } else {
                      CustomUtils.errorSnackbar(
                          context, "Incorrect Credentials");
                    }
                  },

                  label: Text("Continue"),
                  isExtended: true,
                  backgroundColor: Colors.deepPurple,
                  // icon: Icon(  Icons.login_outlined,),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
