
import 'package:food_delivery/model/products_model.dart';
import 'package:get/get.dart';

import '../data/repository/recommended_product_repo.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductReppo;
  RecommendedProductController({required this.recommendedProductReppo});
  List<dynamic> _recommendedProductList=[];
  List<dynamic> get recommendedProductList=>_recommendedProductList;
  bool _isLoaded=false;
  bool get isLoaded=>_isLoaded;
  Future<void>  getRecommendedProductList()async{
    Response response=await recommendedProductReppo.getRecommendedProductList();
    if(response.statusCode==200){
      print("got");
      _recommendedProductList=[];
     _recommendedProductList.addAll(Product.fromJson(response.body).products);
     print(_recommendedProductList);
     _isLoaded=true;
      update();
    }else{

    }
  }
}