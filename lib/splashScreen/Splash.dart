import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takhleekish/main.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
void initState()
{
  super.initState();
  Timer(Duration(seconds: 5), ()=> {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage() ,))},);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(width: double.infinity,
          height: double.infinity,
          child: Image.asset("assests/images/splashpic.jpeg")));
  }
}