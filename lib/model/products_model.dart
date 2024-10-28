import 'package:get/get_connect/http/src/utils/utils.dart';

class Product {
    Product({
        required this.totalSize,
        required this.typeId,
        required this.offset,
        required this.products,
    }){
      this.totalSize=totalSize;
      this.typeId=typeId;
      this.offset=offset;
      this.products=products;
    }

     int? totalSize;
     int? typeId;
     int? offset;
     List<ProductModel> products;

    factory Product.fromJson(Map<String, dynamic> json){ 
        return Product(
            totalSize: json["total_size"],
            typeId: json["type_id"],
            offset: json["offset"],
            products: json["products"] == null ? [] : List<ProductModel>.from(json["products"]!.map((x) => ProductModel.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "total_size": totalSize,
        "type_id": typeId,
        "offset": offset,
        "products": products.map((x) => x?.toJson()).toList(),
    };

}

class ProductModel {
    ProductModel({
        required this.id,
        required this.name,
        required this.description,
        required this.price,
        required this.stars,
        required this.img,
        required this.location,
        required this.createdAt,
        required this.updatedAt,
        required this.typeId,
    });

    final int? id;
    final String? name;
    final String? description;
    final int? price;
    final int? stars;
    final String? img;
    final String? location;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? typeId;

    factory ProductModel.fromJson(Map<String, dynamic> json){ 
        return ProductModel(
            id: json["id"],
            name: json["name"],
            description: json["description"],
            price: json["price"],
            stars: json["stars"],
            img: json["img"],
            location: json["location"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            typeId: json["type_id"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "stars": stars,
        "img": img,
        "location": location,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "type_id": typeId,
    };

}
