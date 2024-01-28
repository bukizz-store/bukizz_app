import 'package:flutter/material.dart';

class FontFamily {
  final String name;

  const FontFamily(this.name);

  // define more font families as needed
  static const FontFamily defaultFamily = FontFamily('Default');
  // static const FontFamily roboto = FontFamily('Roboto');
  static const FontFamily openSans = FontFamily('OpenSans');
  static const FontFamily nunito = FontFamily('Nunito');
}
