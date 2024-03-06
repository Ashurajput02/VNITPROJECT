import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class splashscreenfinal extends StatefulWidget {
  @override
  State<splashscreenfinal> createState() => _splashscreenfinalState();
}

class _splashscreenfinalState extends State<splashscreenfinal> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed('/scanscreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Align(
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/vnitfinal.webp",
            width: 233,
            height: 233,
          ),
        ),
      ),
    );
  }
}
