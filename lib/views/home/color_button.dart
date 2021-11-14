import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorButton extends StatelessWidget {
  const ColorButton({Key? key, required this.color}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        height: 50,
        width: 40,
        child: Icon(Icons.circle, size: 40, color: color),
      ),
      onTap: () {},
    );
  }
}



