import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data.dart';
import 'package:food_delivery/controller/cart_controller.dart';
import 'package:food_delivery/model/cart_model.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/utils/app_color.dart';
import 'package:food_delivery/utils/app_constant.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widget/app_icon.dart';
import 'package:food_delivery/widget/big_text.dart';
import 'package:food_delivery/widget/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> carItemPerOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (carItemPerOrder.containsKey(getCartHistoryList[i].time)) {
        carItemPerOrder.update(getCartHistoryList[i].time!, (e) => ++e);
      } else {
        carItemPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartItemsOrderTimeToList() {
      return carItemPerOrder.entries.map((e) => e.value).toList();
    }
    List<String> cartOrderTimeToList() {
      return carItemPerOrder.entries.map((e) => e.key).toList();
    }
    List<int> itemPerOrder = cartItemsOrderTimeToList();
    var listCount = 0;
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColor.mainColor,
            width: double.maxFinite,
            height: Dimension.height10*10,
            padding: EdgeInsets.only(top: Dimension.height15*3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Cart History",
                  color: Colors.white,
                ),
                Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                )
              ],
            ),
          ),
          GetBuilder<CartController>(
            builder: (controller) {
             return controller.getCartHistoryList().length>0
              ?Expanded(
            child: Container(
                height: 500,
                margin: EdgeInsets.only(
                    top: Dimension.height20,
                    left: Dimension.width20,
                    right: Dimension.width20),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    children: [
                      for (int i = 0; i < itemPerOrder.length; i++)
                        Container(
                          margin: EdgeInsets.only(bottom: Dimension.height20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (() {
                                DateTime parseData =
                                    DateFormat("yyyy-MM-dd HH:mm:ss").parse(
                                        getCartHistoryList[listCount].time!);
                                var inputData =
                                    DateTime.parse(parseData.toString());
                                var outPut = DateFormat("MM/dd/yyyy hh:mm a");
                                var outputDate = outPut.format(inputData);
                                return BigText(text: outputDate);
                              }()),
                              SizedBox(
                                height: Dimension.height10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                      direction: Axis.horizontal,
                                      children: List.generate(
                                       itemPerOrder[i],
                                          (index) {
                                        if (listCount <
                                            getCartHistoryList.length) {
                                          listCount++;
                                        }
                                        return Container(
                                          height: Dimension.height10*8,
                                          width: Dimension.height10*8,
                                          margin: EdgeInsets.only(
                                              right: Dimension.width10 / 2),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimension.radius20 / 2),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    AppConstant.BASE_URL +
                                                        "/uploads/" +
                                                        getCartHistoryList[
                                                                listCount - 1]
                                                            .img!)),
                                          ),
                                        );
                                      })),
                                  Container(
                                    height: Dimension.height10*8,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SmallText(
                                          text: "Total",
                                          color: Colors.black,
                                        ),
                                        BigText(
                                            text: itemPerOrder[i].toString() +
                                                " Items"),
                                        GestureDetector(
                                          onTap: (){
                                             var orderTime=cartOrderTimeToList();
                                             Map<int,CartModel> moreOrder={};
                                             for(int k=0;k<getCartHistoryList.length;k++){
                                              if(getCartHistoryList[k].time==orderTime[i]){
                                                  moreOrder.putIfAbsent(getCartHistoryList[k].id!, (){  
                                                    return CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[k])));
                                                  });
                                              }
                                             }
                                             Get.find<CartController>().setItem=moreOrder;
                                             Get.find<CartController>().addToCartList();
                                             Get.to(()=>CartPage());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimension.width10,
                                                vertical: Dimension.height10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimension.radius20 / 3),
                                                border: Border.all(
                                                    width: 1,
                                                    color: AppColor.mainColor)),
                                            child: SmallText(
                                              text: "one more",
                                              color: AppColor.mainColor,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                )),
          ):NoData();
            },)
        ],
      ),
    );
  }
}
