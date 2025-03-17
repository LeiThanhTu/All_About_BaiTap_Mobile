import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/components_screen.dart';
import 'screens/text_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Sample',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/components': (context) => ComponentsScreen(),
        '/textDetail': (context) => TextDetailScreen(),
      },
    );
  }
}
