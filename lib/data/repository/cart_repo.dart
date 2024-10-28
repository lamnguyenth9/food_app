import 'dart:convert';

import 'package:food_delivery/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../model/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});
  List<String> cart = [];
  List<String> cartHistory = [];
  void addToCartList(List<CartModel> cartList) {
    // sharedPreferences.remove(AppConstant.CART_LIST);
    // sharedPreferences.remove(AppConstant.CART_HISTORY);
    cart = [];
    var time = DateTime.now().toString();
    cartList.forEach((e) {
      e.time = time;
      return cart.add(jsonEncode(e));
    });

    sharedPreferences.setStringList(AppConstant.CART_LIST, cart);
    print(sharedPreferences.getStringList(AppConstant.CART_LIST));
  }

  List<CartModel> getCartList() {
    List<CartModel> cartList = [];
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstant.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstant.CART_LIST)!;
    }
    carts.forEach((e) {
      cartList.add(CartModel.fromJson(jsonDecode(e)));
    });
    carts.forEach((e) => CartModel.fromJson(jsonDecode(e)));
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    List<CartModel> cartListHistory = [];
    List<String> cartHistoryKey = [];
    if (sharedPreferences.containsKey(AppConstant.CART_HISTORY)) {
      cartHistoryKey =
          sharedPreferences.getStringList(AppConstant.CART_HISTORY)!;
    }
    cartHistoryKey.forEach((key) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(key)));
    });
    print("HAHA ${cartListHistory.length}");
    print(cartListHistory);
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstant.CART_HISTORY)) {
      cartHistory = sharedPreferences.getStringList(AppConstant.CART_HISTORY)!;
    }
    for (int i = 0; i < cart.length; i++) {
      print("history list" + cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstant.CART_HISTORY, cartHistory);
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstant.CART_LIST);
  }
  
}
