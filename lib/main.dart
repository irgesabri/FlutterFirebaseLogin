import 'package:ahbap/root_page.dart';
import 'package:flutter/material.dart';
import 'auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ahbap login",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RootPage(
        auth: new Auth(),
      ),
    );
  }
}
