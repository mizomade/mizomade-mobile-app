import 'package:flutter/material.dart';
import 'package:mizomade/screens/accounts/Login.dart';
import 'package:mizomade/utils/States.dart';
import 'package:mizomade/widgets/ChangeThemeButton.dart';
import 'package:provider/provider.dart';

import '../Password/ForgotPassword.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool night = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<Profile>(builder: (context, provider, child) {
      return provider.isAuthenticated == true
          ? Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
                elevation: 2,
                title: Text(
                  "Settings",
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_outlined,
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.lock_outlined),
                        title: Text("Change Password"),
                        trailing: Icon(Icons.chevron_right_outlined),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.language_outlined),
                        title: Text("Language"),
                        trailing: Icon(Icons.chevron_right_outlined),
                        onTap: () {},
                      ),
                      Divider(
                        height: 10,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.dark_mode_outlined,
                        ),
                        title: Text("Night mode"),
                        trailing: ChangeThemeButtonWidget(),
                      ),
                      Divider(
                        height: 10,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.logout_outlined,
                        ),
                        onTap: () {
                          final Profile profile =
                              Provider.of<Profile>(context, listen: false);
                          profile.setAuthenticated = false;
                          Navigator.pop(context);
                        },
                        title: Text("Singout"),
                      )
                    ],
                  ),
                ),
              ),
            )
          : LoginPage();
    });
  }
}
