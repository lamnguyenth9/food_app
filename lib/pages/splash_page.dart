import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/home/home_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController _controller;
  @override
  void initState() {

    _controller=AnimationController(vsync: this,duration: Duration(seconds: 1))..forward();
    
    animation= CurvedAnimation(parent: _controller, curve: Curves.linear);
    Timer(
      Duration(seconds: 2),
      ()=>Get.to(HomePage())
    );
    super.initState();
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: animation,
          child: Image.asset("assets/image/logo.png",width: Dimension.splashImg,),),
      )
    );
  }
}