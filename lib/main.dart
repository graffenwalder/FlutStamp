import 'package:flutter/material.dart';
import 'screens/main_menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xff00b347),
          scaffoldBackgroundColor: Colors.white),
      home: MainMenu(),
    );
  }
}
