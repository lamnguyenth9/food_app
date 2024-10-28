import 'package:food_delivery/model/products_model.dart';

class CartModel {
  CartModel({this.product, this.id, this.name, this.price, this.img,
      this.quantity, this.time, this.isExist,} );

  int? id;
  String? name;

  int? price;
  bool? isExist;
  String? img;
  int? quantity;
  String? time;
  ProductModel? product;

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      img: json["img"],
      quantity: json["quantity"],
      time: json["time"],
      isExist: json['isExist'],
      product: ProductModel.fromJson(json['product'])
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "img": img,
        "quantity": quantity,
        "time": time,
        "isExist": isExist,
        "product":product!.toJson()
      };
}
