import 'package:flutter/material.dart';
import 'package:food_delivery/controller/cart_controller.dart';
import 'package:food_delivery/controller/popular_product_controller.dart';
import 'package:food_delivery/controller/recommended_product_controller.dart';

import 'package:food_delivery/pages/splash_page.dart';
import 'package:food_delivery/route/routes_helper.dart';
import 'package:get/get.dart';

import 'helper/dependencies.dart'as dep;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    Get.find<CartController>().getCartData();
   
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: RoutesHelper.initial,
      
      home:   SplashPage()
    );
  }
}

