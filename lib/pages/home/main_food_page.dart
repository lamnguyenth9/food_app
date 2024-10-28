import 'package:flutter/material.dart';
import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/utils/app_color.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widget/big_text.dart';
import 'package:food_delivery/widget/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
          child: Container(
            margin:  EdgeInsets.only(top: Dimension.height45,bottom: Dimension.height15),
            padding: EdgeInsets.only(right:Dimension.width20,left: Dimension.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BigText(
                      text: 'Viet Nam',
                      color: AppColor.mainColor,
                      ),
                    Row(
                      children: [
                        SmallText(text: 'Ho Chi Minh'),
                        Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                Center(
                  child: Container(
                    width: Dimension.height45,
                    height: Dimension.height45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimension.radius20),
                      color: AppColor.mainColor
                    ),
                    child: Icon(Icons.search,color: Colors.white,size: Dimension.iconSize24,),
                  ),
                )
              ],
            ),
          ),
              ),
              Expanded(child: SingleChildScrollView(child: FoodPageBody())),

        ],
      ),
     floatingActionButton: FloatingActionButton(onPressed: (){
      print(MediaQuery.of(context).size.width);
     }),
    );
  }
}