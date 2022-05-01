import 'package:flutter/material.dart';
import 'package:mizomade/utils/States.dart';
import 'package:provider/provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
      activeTrackColor: Colors.deepPurpleAccent,
      activeColor: Colors.deepPurple.shade900,
      value: themeProvider.isDarkMode,
      onChanged: (value){
        final provider = Provider.of<ThemeProvider>(context,listen: false);
        provider.toggleTheme(value);
      },

    );
  }
}