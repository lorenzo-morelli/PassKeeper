import 'package:flutter/material.dart';
import 'package:passkeeper/shared/constants.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black, fontFamily: '');
    final styleHint = TextStyle(color: Colors.black54, fontFamily: '');
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      height: 42,
      margin: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Constants.cornRad),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.only(left: 6),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            icon: Icon(Icons.search, color: style.color),
            suffixIcon: widget.text.isNotEmpty
                ? GestureDetector(
              child: Icon(Icons.close, color: style.color),
              onTap: () {
                controller.clear();
                widget.onChanged('');
              },
            ) : null,
            hintText: widget.hintText,
            hintStyle: style,
            border: InputBorder.none,
          ),
          style: style,
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}