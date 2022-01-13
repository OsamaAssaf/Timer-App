import 'package:countdown_timer/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: const Color(0xff350f75),
        primaryColor: const Color(0xff902b16),
        shadowColor: Colors.white,
      ),
      home: const Home(),
    );
  }
}
