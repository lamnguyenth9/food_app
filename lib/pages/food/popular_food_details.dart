import 'package:flutter/material.dart';
import 'package:food_delivery/controller/cart_controller.dart';
import 'package:food_delivery/controller/popular_product_controller.dart';
import 'package:food_delivery/model/products_model.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/utils/app_constant.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widget/app_column.dart';
import 'package:food_delivery/widget/app_icon.dart';
import 'package:food_delivery/widget/text_details.dart';
import 'package:get/get.dart';

import '../../utils/app_color.dart';
import '../../widget/big_text.dart';
import '../../widget/icon_and_text.dart';
import '../../widget/small_text.dart';

class PopularFoodDetails extends StatefulWidget {
  final ProductModel productModel;
  const PopularFoodDetails({
    super.key,
    required this.productModel,
  });

  @override
  State<PopularFoodDetails> createState() => _PopularFoodDetailsState();
}

class _PopularFoodDetailsState extends State<PopularFoodDetails> {
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>()
        .initProduct(widget.productModel, Get.find<CartController>());

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimension.popularFoodImage,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(AppConstant.BASE_URL +
                            "/uploads/" +
                            widget.productModel.img.toString()),
                        fit: BoxFit.cover)),
              )),
          Positioned(
              top: Dimension.height45,
              left: Dimension.width20,
              right: Dimension.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const AppIcon(icon: Icons.arrow_back_ios)),
                  GetBuilder<PopularProductController>(
                    builder: (controller) {
                      return GestureDetector(
                        onTap: (){
                          Get.to(()=>const CartPage());
                        },
                        child: Stack(
                          children: [
                            const AppIcon(icon: Icons.shopping_cart_outlined),
                            Get.find<PopularProductController>().totalItem >= 1
                                ? Positioned(
                                  right: -0.5,
                                  top: 1,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      
                                      color: AppColor.mainColor
                                    ),
                                    child: Text(
                                      
                                      controller.totalItem.toString(),textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white
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
              )),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimension.popularFoodImage - 20,
              child: Container(
                  padding: EdgeInsets.only(
                      left: Dimension.width20, right: Dimension.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimension.radius20),
                          topRight: Radius.circular(Dimension.radius20)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(
                        text: widget.productModel.name.toString(),
                      ),
                      SizedBox(
                        height: Dimension.height10,
                      ),
                      BigText(text: 'Introduce'),
                      SizedBox(
                        height: Dimension.height10,
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                              child: TextDetails(
                                  text: widget.productModel.description
                                      .toString())))
                    ],
                  ))),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
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
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(false);
                        },
                        child: Icon(
                          Icons.remove,
                          color: AppColor.signColor,
                        ),
                      ),
                      SizedBox(
                        width: Dimension.width10 / 2,
                      ),
                      BigText(text: popularProduct.inCartItem.toString()),
                      SizedBox(
                        width: Dimension.width10 / 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(true);
                        },
                        child: Icon(
                          Icons.add,
                          color: AppColor.signColor,
                        ),
                      )
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
                        popularProduct.addItem(widget.productModel);
                      },
                      child: BigText(
                        text: "\$${widget.productModel.price} | Add to cart",
                        color: Colors.white,
                      )),
                )
              ],
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}
