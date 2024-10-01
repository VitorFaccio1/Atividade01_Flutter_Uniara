import 'package:flutter/material.dart';
import 'package:front/Store/register.dart';
import 'package:front/store/list.dart';
import 'user/login.dart';
import 'user/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => RegisterUser(),
        '/store/register': (context) => RegisterStore(),
        '/stores': (context) => ListStorePage(),
      },
    );
  }
}
