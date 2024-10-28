import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimension.dart';

class BigText extends StatelessWidget {
   Color? color;
  final String text;
  double size;
  TextOverflow overflow;
   BigText({super.key, this.color=Colors.black, required this.text,this.size=0,this.overflow=TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
          text,
          maxLines: 1,
          overflow: overflow,
          
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w400,
            fontFamily: 'Roboto',
            fontSize:size==0? Dimension.font20:size
          ),
    );
  }
}