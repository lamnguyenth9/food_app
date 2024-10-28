import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/dimension.dart';
import 'big_text.dart';
import 'icon_and_text.dart';
import 'small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: text,size: Dimension.font26,),
                    SizedBox(
                      height: Dimension.height10,
                    ),
                    Row(
                      children: [
                        Wrap(
                            children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            color: AppColor.mainColor,
                            size: 15,
                          );
                        })),
                        SizedBox(
                          width: 10,
                        ),
                        SmallText(text: "4.5"),
                        SizedBox(
                          width: 10,
                        ),
                        SmallText(text: "1278 comments")
                      ],
                    ),
                    SizedBox(
                      height: Dimension.height20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconAndText(
                            icon: Icons.circle_sharp,
                            text: 'Normal',
                            iconColor: AppColor.iconColor1),
                        IconAndText(
                            icon: Icons.location_on,
                            text: '1.7 km',
                            iconColor: AppColor.mainColor),
                        IconAndText(
                            icon: Icons.access_time_rounded,
                            text: '32 min',
                            iconColor: AppColor.iconColor2)
                      ],
                    ),
                    
                  ],
                );
  }
}