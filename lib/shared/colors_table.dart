import 'package:flutter/material.dart';

import 'color_tile.dart';
import 'constants.dart';

class ColorsTable extends StatefulWidget {
  const ColorsTable({Key? key, required this.func, this.color, required this.radius}) : super(key: key);
  final Color? color;
  final Function func;
  final double radius;

  @override
  _ColorsTableState createState() => _ColorsTableState();
}

class _ColorsTableState extends State<ColorsTable> {
  final colors = Constants.colors;
  int chosen = 0;

  @override
  void initState() {
    for (int i = 0; i < colors.length; i++) {
      if (widget.color == colors[i]) {
        chosen = i;
        break;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(children: [
            GestureDetector(
                child: ColorTile(color: colors[0], id: 0, chosen: chosen, radius: widget.radius),
                onTap: () {
                  setState(() => chosen = 0);
                  widget.func(chosen);
                }),
            GestureDetector(
                child: ColorTile(color: colors[1], id: 1, chosen: chosen, radius: widget.radius),
                onTap: () {
                  setState(() => chosen = 1);
                  widget.func(chosen);
                }),
            GestureDetector(
                child: ColorTile(color: colors[2], id: 2, chosen: chosen, radius: widget.radius),
                onTap: () {
                  setState(() => chosen = 2);
                  widget.func(chosen);
                }),
            GestureDetector(
                child: ColorTile(color: colors[3], id: 3, chosen: chosen, radius: widget.radius),
                onTap: () {
                  setState(() => chosen = 3);
                  widget.func(chosen);
                }),
          ]),
          TableRow(
            children: [
              GestureDetector(
                  child: ColorTile(color: colors[4], id: 4, chosen: chosen, radius: widget.radius),
                  onTap: () {
                    setState(() => chosen = 4);
                    widget.func(chosen);
                  }),
              GestureDetector(
                  child: ColorTile(color: colors[5], id: 5, chosen: chosen, radius: widget.radius),
                  onTap: () {
                    setState(() => chosen = 5);
                    widget.func(chosen);
                  }),
              GestureDetector(
                  child: ColorTile(color: colors[6], id: 6, chosen: chosen, radius: widget.radius),
                  onTap: () {
                    setState(() => chosen = 6);
                    widget.func(chosen);
                  }),
              GestureDetector(
                  child: ColorTile(color: colors[7], id: 7, chosen: chosen, radius: widget.radius),
                  onTap: () {
                    setState(() => chosen = 7);
                    widget.func(chosen);
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
