import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  const AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(aspectRatio: 2.48, child: Image.asset('assets/images/home.png', fit: BoxFit.cover)),
        Column(
          children: [
            SizedBox(height: 35),
            Wrap(
              runSpacing: -6,
              children: [
                Center(
                  child: Text(
                    'PassKeeper.',
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 60),
                Center(
                  child: Text(
                    'A safe place to store all',
                    style: TextStyle(fontSize: 19, fontStyle: FontStyle.italic),
                  ),
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontFamily: 'GentiumBook', color: Colors.black, fontSize: 19, fontStyle: FontStyle.italic),
                      children: const [
                        TextSpan(text: 'your '),
                        TextSpan(
                          text: 'passwords',
                          style: TextStyle(decoration: TextDecoration.lineThrough),
                        ),
                        TextSpan(text: '.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
