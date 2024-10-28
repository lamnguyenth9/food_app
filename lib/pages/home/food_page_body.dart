import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controller/popular_product_controller.dart';
import 'package:food_delivery/controller/recommended_product_controller.dart';
import 'package:food_delivery/model/products_model.dart';
import 'package:food_delivery/pages/food/popular_food_details.dart';
import 'package:food_delivery/pages/food/recommend_food.dart';
import 'package:food_delivery/utils/app_color.dart';
import 'package:food_delivery/utils/app_constant.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widget/big_text.dart';
import 'package:food_delivery/widget/icon_and_text.dart';
import 'package:food_delivery/widget/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.9);
  double _currentPageValue = 0;
  double _scaleFactor = 0.8;
  double _height = Dimension.pageViewContainer;
  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          GetBuilder<PopularProductController>(
            builder: ( popularProducts) { 
               return popularProducts.isLoaded
               ?Container(
              height: 320,
              child:  PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length,
                  itemBuilder: (context, index) {
                    return _buildPageItem(index,popularProducts.popularProductList[index]);
                  },
                ),
              
            ):Center(
              child: CircularProgressIndicator(),
            );
             },
            
          ),
          GetBuilder<PopularProductController>(builder: (popularProducts){
            return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
            position: _currentPageValue.toInt(),
            decorator: DotsDecorator(
              color: AppColor.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
          }),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: Dimension.width30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BigText(text: 'Recommended'),
                SizedBox(
                  width: Dimension.width10,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: BigText(
                    text: '.',
                    color: Colors.black26,
                  ),
                ),
                SizedBox(
                  width: Dimension.width10,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: SmallText(text: 'Food paring'),
                )
              ],
            ),
          ),
          GetBuilder<RecommendedProductController>(
            builder: (recommendedProducts){
              return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recommendedProducts.recommendedProductList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Get.to(()=>RecommendFood(id: index,));
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: Dimension.width20,
                      right: Dimension.width20,
                      bottom: Dimension.height10),
                  child: Row(
                    children: [
                      Container(
                        width: Dimension.listViewImgSize,
                        height: Dimension.listViewImgSize,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimension.radius20),
                            color: Colors.white38,
                            image: DecorationImage(
                                image: NetworkImage(
                                  AppConstant.BASE_URL+ "/uploads/"+recommendedProducts.recommendedProductList[index].img,
                                ),
                                fit: BoxFit.cover)),
                      ),
                      //text
                      Expanded(
                        child: Container(
                          height: Dimension.listViewTextSize,
                          padding: EdgeInsets.only(),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Dimension.radius20),
                                  bottomRight: Radius.circular(Dimension.radius20)),
                              color: Colors.white),
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: Dimension.width10, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BigText(text: recommendedProducts.recommendedProductList[index].name),
                                SizedBox(
                                  height: Dimension.height10,
                                ),
                                SmallText(text: recommendedProducts.recommendedProductList[index].location),
                                SizedBox(
                                  height: Dimension.height10,
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
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
            }
            )
        ],
      );
    
  }

  Widget _buildPageItem(int index,ProductModel popularProducts) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.to(()=>PopularFoodDetails(productModel: popularProducts,));
            },
            child: Container(
              height: Dimension.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimension.width10, right: Dimension.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.radius30),
                  color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                  image: DecorationImage(
                      image: NetworkImage(AppConstant.BASE_URL+ "/uploads/"+popularProducts.img.toString()),
                      fit: BoxFit.cover)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimension.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimension.width30,
                  right: Dimension.width30,
                  bottom: Dimension.width30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.radius30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0))
                  ]),
              child: Container(
                padding: EdgeInsets.only(top: 10, right: 15, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: popularProducts.name.toString()),
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
                        SmallText(text: popularProducts.stars.toString()),
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
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
