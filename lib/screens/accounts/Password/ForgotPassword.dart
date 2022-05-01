import 'package:flutter/material.dart';
import 'package:mizomade/screens/accounts/Password/OTPPassword.dart';
import 'package:intl_phone_field/intl_phone_field.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _phonenumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(

          child: ListView(
            shrinkWrap: true,
            children: [
              Text("Forgot password ?" , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text("Enter mobile number linked with your account"),
              SizedBox(height: 20,),
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
                // onCountryChanged: (country) {
                //   print('Country changed to: ' + country.name);
                //   // _phonenumber.text = phone.completeNumber;
                //
                // },
              ),

              Container(

                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  style:ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                      )),


                  onPressed: (){
                    print("PHONENUMBER" + _phonenumber.text );
                    // setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPPassword()));

                    // });
                  },


                  child: Text("SEND OTP",style: TextStyle(
                      color: Colors.white

                  ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
