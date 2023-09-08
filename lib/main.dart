import 'package:flutter/material.dart';
import 'package:xo_app/screens/homeScreen.dart';

import 'screens/GameScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Button Grid Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameScreen(),
      routes: {
        HomePage.iD: (context) => HomePage(),
        GameScreen.iD: (context) => GameScreen()
      },
      initialRoute: HomePage.iD,
    );
  }
}
