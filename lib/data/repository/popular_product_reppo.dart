import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/utils/app_constant.dart';
import 'package:get/get.dart';

class PopularProductReppo extends GetxService{
  final ApiClient apiClient;

  PopularProductReppo({required this.apiClient});
  Future<Response> getPopularProductList()async{
     return await apiClient.getData(AppConstant.POPULAR_PRODUCT_URI);
  }
}