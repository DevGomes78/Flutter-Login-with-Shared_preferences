import 'package:flutter/material.dart';
import 'package:flutter_logar_listar/views/splash_page.dart';

void main() =>  runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.deepPurple,
      ),
      home: SplashScreen(),
    );
  }
}