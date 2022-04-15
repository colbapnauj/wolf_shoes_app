import 'package:flutter/material.dart';
import 'package:wolf_app/routes/routes.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wolf Shoes App',
      initialRoute: 'login',
      routes: appRoutes,
    );
  }
}
