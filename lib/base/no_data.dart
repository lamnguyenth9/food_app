import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset("assets/image/empty.png",
      height: MediaQuery.of(context).size.height*0.5,
      width: MediaQuery.of(context).size.width*0.5,),
    );
  }
}