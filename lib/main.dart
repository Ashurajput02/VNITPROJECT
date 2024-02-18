import 'package:flutter/material.dart';
import 'config/approutes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Urbanist',
      ),
      initialRoute: '/',
      routes: AppRoutes.pages,
    );
  }
}
