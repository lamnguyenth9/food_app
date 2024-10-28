import 'package:flutter/material.dart';
import 'package:food_delivery/controller/popular_product_controller.dart';
import 'package:food_delivery/controller/recommended_product_controller.dart';
import 'package:food_delivery/model/products_model.dart';
import 'package:food_delivery/utils/app_color.dart';
import 'package:food_delivery/utils/app_constant.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widget/app_icon.dart';
import 'package:food_delivery/widget/big_text.dart';
import 'package:food_delivery/widget/text_details.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../cart/cart_page.dart';

class RecommendFood extends StatelessWidget {
  final int id;
  const RecommendFood({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final ProductModel recommendedFood =
        Get.find<RecommendedProductController>().recommendedProductList[id];
    Get.find<PopularProductController>()
        .initProduct(recommendedFood, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 60,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: AppIcon(icon: Icons.clear)),
                GetBuilder<PopularProductController>(
                    builder: (controller) {
                      return GestureDetector(
                        onTap: (){
                          Get.to(()=>CartPage());
                        },
                        child: Stack(
                          children: [
                            AppIcon(icon: Icons.shopping_cart_outlined),
                            Get.find<PopularProductController>().totalItem >= 1
                                ? Positioned(
                                  right: -0.5,
                                  top: 1,
                                  child: Container(
                                    height: Dimension.height20,
                                    width:  Dimension.height20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      
                                      color: AppColor.mainColor
                                    ),
                                    child: Text(
                                      
                                      controller.totalItem.toString(),textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Dimension.font16
                                      ),
                                    ),
                                  )
                                )
                                : Container()
                          ],
                        ),
                      );
                    },
                  )
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimension.radius20),
                        topRight: Radius.circular(Dimension.radius20)),
                    color: Colors.white),
                child: Center(
                    child: BigText(text: recommendedFood.name.toString())),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.yellow,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstant.BASE_URL +
                    "/uploads/" +
                    recommendedFood.img.toString(),
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: Dimension.width20, right: Dimension.width20),
                child:
                    TextDetails(text: recommendedFood.description.toString()),
              )
            ],
          ))
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          return Container(
        decoration: BoxDecoration(
            color: AppColor.buttonBackgroudColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimension.radius20 * 2),
                topRight: Radius.circular(Dimension.radius20 * 2))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: Dimension.width20 * 2.5,
                  right: Dimension.width20 * 2.5,
                  top: Dimension.height10,
                  bottom: Dimension.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(false);
                    },
                    child: AppIcon(
                      iconSize: Dimension.iconSize24,
                      icon: Icons.remove,
                      backgroundColor: AppColor.mainColor,
                      iconColor: Colors.white,
                    ),
                  ),
                  BigText(
                    text: "\$${recommendedFood.price}  " + 'X' + '  ${controller.inCartItem}',
                    color: AppColor.mainBlackColor,
                    size: Dimension.font26,
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(true);
                    },
                    child: AppIcon(
                      iconSize: Dimension.iconSize24,
                      icon: Icons.add,
                      backgroundColor: AppColor.mainColor,
                      iconColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                      padding: EdgeInsets.only(
                          top: Dimension.height20,
                          bottom: Dimension.height20,
                          left: Dimension.width20,
                          right: Dimension.width20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.radius20),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: AppColor.mainColor,
                      )),
                  Container(
                    padding: EdgeInsets.only(
                        top: Dimension.height20,
                        bottom: Dimension.height20,
                        left: Dimension.width20,
                        right: Dimension.width20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.radius20),
                        color: AppColor.mainColor),
                    child: GestureDetector(
                      onTap: (){
                        controller.addItem(recommendedFood);
                      },
                      child: BigText(
                        text: "\$${recommendedFood.price} | Add to cart",
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
            ),
          ],
        ),
      );
        },)
    );
  }
}
