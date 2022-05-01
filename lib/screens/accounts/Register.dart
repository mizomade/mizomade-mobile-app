import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mizomade/screens/accounts/OTPRegister.dart';
import 'package:mizomade/utils/Network.dart';
import 'package:provider/provider.dart';

import '../../utils/CustomUtils.dart';
import '../../utils/States.dart';

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
          onPressed: () { Navigator.pop(context);},
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // FlutterLogo(
              //   size: 100,
              // ),
              Center(
                  child: Image.asset(
                    'assets/signature/mlogo.png',
                    height: 80,
                    width: 80,
                  )),

// Text("Log in",style: TextStyle( fontSize: 20),),
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
                    border: OutlineInputBorder(
                      // borderRadius: BorderRadius.circular(8)
                    ),
                    labelText: "Username",
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),


              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 20),
              //   width: MediaQuery.of(context).size.width * 0.9,
              //   child: TextFormField(
              //     controller: _phonenumber,
              //     decoration: InputDecoration(
              //       suffixIcon: Icon(
              //         Icons.phone_outlined,
              //       ),
              //       border: OutlineInputBorder(
              //           // borderRadius: BorderRadius.circular(8)
              //
              //       ),
              //       labelText: "Phone Number",
              //     ),
              //   ),
              // ),
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
                      border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(8)

                      ),
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
                      border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(8)

                      ),
                      labelText: "Confirm Password"),
                  onChanged:(value){
                    if(_password1 != _password2){
                      setState(() {
                        same = false;
                      });
                    }
                    else if(_password1 == _password2){
                      setState(() {
                        same= true;
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
                  // onCountryChanged: (country) {
                  //   print('Country changed to: ' + country.name);
                  //   // _phonenumber.text = phone.completeNumber;
                  //
                  // },
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
                    bool result= true;
                    // var result = await register1(_username.text, _password1.text,_phonenumber.text) ;
                    print("Results");
                    print(result);
                    if(result == true){
                      // Provider.of<Profile>(
                      //     context, listen: false).setAuthenticated=true;
                      // CustomUtils.successSnackBar(context, "Logged in Successfull");

                      Navigator.push(context,MaterialPageRoute(builder: (context)=>OTPRegister()));

                    }
                    else{
                      CustomUtils.errorSnackbar(context, "Incorrect Credentials");
                    }

                  },
                  // icon: Icon(
                  //   Icons.arrow_forward_outlined,
                  // ),

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

              // Container(
              //     width: MediaQuery.of(context).size.width*0.9,
              //
              //     padding: EdgeInsets.symmetric(horizontal: 1,vertical: 0),
              //     child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Text("Don't have an account?"),
              //           TextButton(onPressed: (){}, child: Text("Register",style: TextStyle(color: Colors.deepPurple),))])),
            ],
          ),
        ),
      ),
    );
  }
}
