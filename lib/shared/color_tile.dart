import 'package:flutter/material.dart';

class ColorTile extends StatefulWidget {
  const ColorTile({Key? key, required this.color, required this.id, required this.chosen, required this.radius}) : super(key: key);
  final Color color;
  final int chosen;
  final int id;
  final double radius;

  @override
  _ColorTileState createState() => _ColorTileState();
}

class _ColorTileState extends State<ColorTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
        radius: widget.radius,
        backgroundColor: widget.color,
        child: widget.id == widget.chosen
            ? Stack(
                children: const [
                  Icon(Icons.check, color: Colors.white),
                ],
              )
            : null,
      ),
      padding: EdgeInsets.symmetric(vertical: 10),
    );
  }
}
