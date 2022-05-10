import 'package:flutter/material.dart';

class NewPasswordForgot extends StatefulWidget {
  const NewPasswordForgot({Key key}) : super(key: key);

  @override
  _NewPasswordForgotState createState() => _NewPasswordForgotState();
}

class _NewPasswordForgotState extends State<NewPasswordForgot> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Text(
                  "Enter new password",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
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
                      labelText: "New Password"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
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
                      labelText: "Confirm New Password"),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "SAVE",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
