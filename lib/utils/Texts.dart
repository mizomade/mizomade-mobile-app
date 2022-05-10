// static const TextStyle TitleStyle =
// TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
import 'dart:convert';

import 'package:flutter/material.dart';
class TextUtils {
  // static const TextStyle optionStyle =
  // TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));



}

convertingTitles( code){
  return Utf8Decoder().convert(code);
}
