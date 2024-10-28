import 'package:food_delivery/controller/cart_controller.dart';
import 'package:food_delivery/controller/popular_product_controller.dart';
import 'package:food_delivery/controller/recommended_product_controller.dart';
import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/data/repository/popular_product_reppo.dart';
import 'package:food_delivery/data/repository/recommended_product_repo.dart';
import 'package:food_delivery/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init()async{
  final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  Get.lazyPut(()=>sharedPreferences);
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstant.BASE_URL));

  Get.lazyPut(()=>PopularProductReppo(apiClient: Get.find()));

  Get.lazyPut(()=>PopularProductController(popularProductReppo: Get.find()));

  Get.lazyPut(()=>RecommendedProductRepo(apiClient: Get.find()));

  Get.lazyPut(()=>RecommendedProductController(recommendedProductReppo: Get.find()));

  Get.lazyPut(()=>CartRepo(sharedPreferences:Get.find()));

  Get.lazyPut(()=>CartController(cartRepo: Get.find()));
}