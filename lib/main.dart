import 'package:flutter/material.dart';
import './rootpage.dart';
import './auth.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      title: "Login demo app",
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: RootPage(auth: Auth()),
    );
  }
}