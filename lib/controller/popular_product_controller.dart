import 'package:flutter/material.dart';
import 'package:food_delivery/controller/cart_controller.dart';
import 'package:food_delivery/data/repository/popular_product_reppo.dart';
import 'package:food_delivery/model/products_model.dart';
import 'package:food_delivery/utils/app_color.dart';
import 'package:get/get.dart';

import '../model/cart_model.dart';

class PopularProductController extends GetxController{
  final PopularProductReppo popularProductReppo;
  PopularProductController({required this.popularProductReppo});
  List<dynamic> _popularProductList=[];
  List<dynamic> get popularProductList=>_popularProductList;
  late CartController _cart;
  bool _isLoaded=false;
  bool get isLoaded=>_isLoaded;
  int _quantity=0;
  int get quantity=>_quantity;
  int _inCartItem=0;
  int get inCartItem=>_inCartItem+_quantity;
  Future<void>  getPopularProductList()async{
    Response response=await popularProductReppo.getPopularProductList();
    if(response.statusCode==200){
      print("got");
      _popularProductList=[];
     _popularProductList.addAll(Product.fromJson(response.body).products);
     print(_popularProductList);
     _isLoaded=true;
      update();
    }else{

    }
  }
  void setQuantity(bool isIncrement){
    if(isIncrement){
      print("1");
      _quantity=checkQuantity(_quantity+1);
    }else{
      _quantity=checkQuantity(_quantity-1);
    }
    update();
  }
  int checkQuantity(int quantity){
    if(_inCartItem+ quantity<0){
      Get.snackbar("Item count", "You can't reduce more",backgroundColor: AppColor.mainColor,colorText: Colors.white);
      if(_inCartItem>0){
        _quantity=-_inCartItem;
        return _quantity;
      }
      return 0;
    }else if(_inCartItem+ quantity>20){
      Get.snackbar("Item decrese", "You can't get more",backgroundColor: AppColor.mainColor,colorText: Colors.white);
      return 20;
    }else{
      return quantity;
    }
  }
  void initProduct(ProductModel product,CartController cart){
    _quantity=0;
    _inCartItem=0;
    _cart=cart;
    var exist=false;
    exist=_cart.existInCart(product);
    if(exist){
      _inCartItem=_cart.getQuantity(product);
    }
  }
  void addItem(ProductModel product){

    _cart.addItem(product, _quantity);
    _quantity=0;
    _inCartItem=_cart.getQuantity(product);
    _cart.items.forEach((key,value){
        print("this is $key quantity is ${value.quantity}");
    });
  
  update();
  }
  int get totalItem{
    return _cart.totalItems;
  }
  List<CartModel>  get cartItem{
    return _cart.getItems;
  }
}