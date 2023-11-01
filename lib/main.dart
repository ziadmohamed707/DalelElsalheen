import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ryadelsalehen/Screens/Favorities.dart';
import 'package:ryadelsalehen/Screens/HomePage.dart';

import 'Screens/Splash.dart';


void main() async{
  await Hive.initFlutter();
  var bookMarkedBox = await Hive.openBox('bookMarked');
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp(box: bookMarkedBox,));
}

class MyApp extends StatelessWidget {
  final Box box;
  MyApp({required this.box});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MySplashScreen(box: box),
      debugShowCheckedModeBanner: false,
    );
  }
  }




