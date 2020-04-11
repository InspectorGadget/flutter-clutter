import 'package:flutter/material.dart';

import 'package:coolio/pages/home/home_ui.dart';
import 'package:coolio/pages/signin/signin_ui.dart';
import 'package:coolio/pages/signup/signup_ui.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coolio-UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      routes: {
        'home': (BuildContext context) => HomePage(),
        'login': (BuildContext context) => SignIn(),
        'register': (BuildContext context) => SignUp(),
      },
      initialRoute: 'home',
    );
  }
}
