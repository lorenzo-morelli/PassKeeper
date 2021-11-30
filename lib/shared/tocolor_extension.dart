import 'package:flutter/material.dart';

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("C", "")
        .replaceAll("o", "")
        .replaceAll("l", "")
        .replaceAll("r", "")
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll("0x", "");
    return Color(int.parse(hexColor, radix: 16));
  }
}