import 'package:flutter/material.dart';
import 'package:traductor/historyPage.dart';
import 'package:traductor/home_page.dart';
import 'package:traductor/login_page.dart';
import 'package:traductor/result_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      routes: {
        "/": (BuildContext context) => LoginPage(),
        "/scan": (BuildContext context) => HomePage(),
        "/history": (BuildContext context) => History(),
      },
    );
  }
}
