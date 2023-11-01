import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'HomePage.dart';


class MySplashScreen extends StatefulWidget {
  final Box box;
  MySplashScreen({required this.box});
  @override
  _MyHomePageState createState() => _MyHomePageState(box: box);
}

class _MyHomePageState extends State<MySplashScreen> {
  Box box;
  _MyHomePageState({required this.box});

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomePage(box: box))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        children: [
          Container(
            color: Color.fromRGBO(215, 232, 237, 1.0),
            height: MediaQuery.of(context).size.height / 4,
          ),
          Container(
            child: Image.asset('images/splash.jpeg'),
          ),
          Expanded(
            child: Container(
              color: Color.fromRGBO(27, 30, 64, 1.0),
              height: 145,
            ),
          ),
        ],
      ),
    );
  }
}
