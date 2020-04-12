import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo/pages/home_page.dart';
import 'package:todo/services/theme_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(ThemeData.light()),
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      title: 'My Tasks',
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
      routes: {
        'home': (BuildContext context) => HomePage(),
      },
      initialRoute: 'home',
    );
  }
}
