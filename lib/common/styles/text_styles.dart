import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle get h1 => const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w800,
    fontSize: 20,
  );

  static TextStyle get title => const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 17,
  );

  static TextStyle get subtitle => TextStyle(
        fontSize: 13,
        color: Colors.grey.shade600,
      );

  static TextStyle get hintText => const TextStyle(color: Colors.grey);

  static TextStyle get link => const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Colors.blue,
      );

  static TextStyle get label => const TextStyle(color: Colors.black);
}
