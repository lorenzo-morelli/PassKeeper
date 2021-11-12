import 'package:flutter/material.dart';
import 'account_list.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Icon(Icons.person),
              SizedBox(width: 10),
              Icon(Icons.settings),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 25),
          Stack(
            children: [
              Image.asset('assets/images/home.png'),
              Column(
                children: [
                  SizedBox(height: 25),
                  Wrap(
                    runSpacing: -10,
                    children: [
                      Center(
                        child: Text(
                          'PassKeeper.',
                          style: TextStyle(
                            fontSize: 35,
                          ),
                        ),
                      ),
                      SizedBox(height: 70),
                      Center(
                        child: Text(
                          'A safe place to store all',
                          style: TextStyle(
                            fontSize: 19,
                          ),
                        ),
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontFamily: 'ZenAntique',
                                color: Colors.black,
                                fontSize: 19),
                            children: const [
                              TextSpan(text: 'your '),
                              TextSpan(
                                text: 'passwords',
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough),
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
          ),
          SizedBox(height: 50),
          Expanded(
            child: AccountList(),
          )
        ],
      ),
    );
  }
}
