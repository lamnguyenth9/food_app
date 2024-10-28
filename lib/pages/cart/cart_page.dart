import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data.dart';
import 'package:food_delivery/controller/cart_controller.dart';
import 'package:food_delivery/controller/popular_product_controller.dart';
import 'package:food_delivery/controller/recommended_product_controller.dart';
import 'package:food_delivery/pages/food/popular_food_details.dart';
import 'package:food_delivery/pages/food/recommend_food.dart';
import 'package:food_delivery/pages/home/home_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/utils/app_color.dart';
import 'package:food_delivery/utils/app_constant.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widget/app_icon.dart';
import 'package:food_delivery/widget/big_text.dart';
import 'package:food_delivery/widget/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: Dimension.width20,
              right: Dimension.width20,
              top: Dimension.height20 * 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroundColor: AppColor.mainColor,
                      iconSize: Dimension.iconSize24,
                    ),
                  ),
                  SizedBox(
                    width: Dimension.width20 * 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => HomePage());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColor.mainColor,
                      iconSize: Dimension.iconSize24,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColor.mainColor,
                    iconSize: Dimension.iconSize24,
                  ),
                ],
              )),
          // GetBuilder<PopularProductController>(
          //   builder: (controller) {
          GetBuilder<CartController>(
            builder: (cartController){
              return cartController.getItems.length>0
              ? Positioned(
                top: Dimension.height20 * 5,
                left: Dimension.width20,
                right: Dimension.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: Dimension.height20),
                  child: MediaQuery.removeViewPadding(
                      context: context,
                      removeTop: true,
                      child: GetBuilder<CartController>(
                        builder: (controller) {
                          return ListView.builder(
                            itemCount: controller.getItems.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 100,
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        var popularIndex =
                                            Get.find<PopularProductController>()
                                                .popularProductList
                                                .indexOf(controller
                                                    .getItems[index].product);
                                        if (popularIndex >= 0) {
                                          Get.to(() => PopularFoodDetails(
                                              productModel: controller
                                                  .getItems[index].product!));
                                        } else {
                                          var recommendedIndex = Get.find<
                                                  RecommendedProductController>()
                                              .recommendedProductList
                                              .indexOf(controller
                                                  .getItems[index].product);
                                          if (recommendedIndex < 0) {
                                            Get.snackbar("History Product",
                                                "Product review is not availble for history product",
                                                backgroundColor:
                                                    AppColor.mainColor,
                                                colorText: Colors.white);
                                          } else {
                                            Get.to(() => RecommendFood(
                                                id: recommendedIndex));
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: Dimension.height20 * 5,
                                        height: Dimension.height20 * 5,
                                        margin: EdgeInsets.only(
                                            bottom: Dimension.height10),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(AppConstant
                                                        .BASE_URL +
                                                    "/uploads/" +
                                                    controller.getItems[index].img
                                                        .toString()),
                                                fit: BoxFit.cover),
                                            borderRadius: BorderRadius.circular(
                                                Dimension.radius20)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimension.width10,
                                    ),
                                    Expanded(
                                        child: Container(
                                      height: Dimension.height20 * 5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(
                                            text:
                                                controller.getItems[index].name!,
                                            color: Colors.black45,
                                          ),
                                          SmallText(text: "Spicy"),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                text:
                                                    "\$${controller.getItems[index].price}",
                                                color: Colors.redAccent,
                                              ),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller.addItem(
                                                          controller
                                                              .getItems[index]
                                                              .product!,
                                                          -1);
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: AppColor.signColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Dimension.width10 / 2,
                                                  ),
                                                  BigText(
                                                      text: controller
                                                          .getItems[index]
                                                          .quantity
                                                          .toString()),
                                                  SizedBox(
                                                    width: Dimension.width10 / 2,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller.addItem(
                                                          controller
                                                              .getItems[index]
                                                              .product!,
                                                          1);
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      color: AppColor.signColor,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      )),
                )):NoData();
            },
          )
          //
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
          return Container(
            height: Dimension.bottomHeight,
            padding: EdgeInsets.only(
                top: Dimension.height30,
                bottom: Dimension.height30,
                left: Dimension.width20,
                right: Dimension.width20),
            decoration: BoxDecoration(
                color: AppColor.buttonBackgroudColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimension.radius20 * 2),
                    topRight: Radius.circular(Dimension.radius20 * 2))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  child: Row(
                    children: [
                      SizedBox(
                        width: Dimension.width10 / 2,
                      ),
                      BigText(
                          text:
                              "Total: \$${cartController.totalAmount.toString()}"),
                      SizedBox(
                        width: Dimension.width10 / 2,
                      ),
                    ],
                  ),
                ),
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
                      onTap: () {
                        print("tapped");
                        cartController.addToHistory();
                      },
                      child: BigText(
                        text: "Check out",
                        color: Colors.white,
                      )),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
