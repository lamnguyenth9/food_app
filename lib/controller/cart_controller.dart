import 'package:flutter/material.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/model/products_model.dart';
import 'package:get/get.dart';

import '../model/cart_model.dart';
import '../utils/app_color.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};
  Map<int,CartModel> get items=>_items;
  List<CartModel> storageItem=[];
  void addItem(ProductModel product, int quantity) {
    var totalQuantity=0;
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (value) {
        totalQuantity=value.quantity!+quantity;
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: value.quantity!+quantity,
            time: DateTime.now().toString(),
            isExist: true,
            product: product);
      });
      if(totalQuantity<=0){
        _items.remove(product.id);
      }
    } else {
      if(quantity>0){
        _items.putIfAbsent(product.id!, () {
        print("hahaha ${product.id!}  $quantity");

        return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            time: DateTime.now().toString(),
            isExist: true,product: product);
      });
      }else{
        Get.snackbar("No item selected", "You must have at least one item",backgroundColor: AppColor.mainColor,colorText: Colors.white);
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }
 bool existInCart(ProductModel product){
    if(_items.containsKey(product.id)){
      return true;
    }
    return false;
  }
  getQuantity(ProductModel product){
    var quantity=0;
    if(_items.containsKey(product.id)){
      _items.forEach((key,value){
        if(key==product.id){
          quantity=value.quantity!;
        }
      });
    }
    return quantity;
  }
  int get totalItems{
    var totalQuantiy=0;
    _items.forEach((key,value){
      totalQuantiy+= value.quantity!;
    });
    return totalQuantiy;
  }
  List<CartModel> get   getItems{
   return _items.entries.map((e){
    return  e.value;
    }).toList();
  }
  int get totalAmount{
    var total=0;
    _items.forEach((key,value){
      total+=value.quantity!*value.price!;
    });
    return total;
  }
 List<CartModel> getCartData(){
    setCart=cartRepo.getCartList();
    return storageItem;
  }
set setCart(List<CartModel> items){
  storageItem=items;
  for(int i=0;i<storageItem.length;i++){
    _items.putIfAbsent(storageItem[i].product!.id!, ()=>storageItem[i]);
  }
}
void addToHistory(){
  cartRepo.addToCartHistoryList();
  clear();
}
void clear(){
  _items={};
  update();
}
List<CartModel> getCartHistoryList(){
  return cartRepo.getCartHistoryList();
}
set setItem(Map<int,CartModel> setItems){
  _items={};
  _items=setItems;
}
void addToCartList(){
  cartRepo.addToCartList(getItems);
  update();
}
}
