import 'package:flutter/material.dart';
import 'package:flutterapi/Screens/home_screen.dart';
import 'package:flutterapi/provider/user_prodviders.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChangeNotifierProvider(
          create: (context) => user_provider(),
          child: HomePage(),
        ));
  }
}
