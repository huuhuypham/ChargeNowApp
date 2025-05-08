import 'package:flutter/material.dart';
import 'screens/start.dart';
import 'screens/login.dart';
import 'screens/signup.dart';

void main() {
  runApp(ChargeNowApp());
}

class ChargeNowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChargeNow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark(
          primary: Colors.tealAccent,
        ),
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Roboto',
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => StartPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
      },
    );
  }
}
