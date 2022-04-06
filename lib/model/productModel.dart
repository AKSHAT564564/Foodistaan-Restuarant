// class Product {
//   //Product Model

//   //  {
//   // "id": index,
//   // "name": "Products $index",
//   // "productImage":
//   //     "https://cdn.pixabay.com/photo/2016/10/09/14/00/vegetable-juices-1725835_960_720.jpg",
//   // "quantity": "5 x65 ml",
//   // "discount-Off": 10,
//   // "categorie": "package $index",
//   // "price": 50.0,
//   //         }

//   final String id;
//   final String name;
//   final String categorie;
//   final String quantity;
//   final double price;
//   final int discountOff;

//   final String productImage;

//   Product({
//     required this.id,
//     required this.name,
//     required this.categorie,
//     required this.quantity,
//     required this.price,
//     required this.discountOff,
//     required this.productImage,
//   });
// }
// To parse this JSON data, do
//

import 'dart:convert';

import 'package:foodistaan_restuarant/model/categoriesModel.dart';

class Product {
  final String id;
  final String name;
  final Categorie? categorie;
  final String description;
  final String quantity;
  final int discountOff;
  final double price;
  final String productImage;

  Product({
    required this.id,
    required this.name,
    required this.categorie,
    required this.description,
    required this.quantity,
    required this.discountOff,
    required this.price,
    required this.productImage,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        categorie: json["categorie"] == null
            ? null
            : Categorie.fromMap(json["categorie"]),
        description: json["description"] == null ? null : json["description"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        discountOff: json["discountOff"] == null ? null : json["discountOff"],
        price: json["price"] == null ? null : json["price"].toDouble(),
        productImage:
            json["productImage"] == null ? null : json["productImage"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "categorie": categorie == null ? null : categorie!.toMap(),
        "description": description == null ? null : description,
        "quantity": quantity == null ? null : quantity,
        "discountOff": discountOff == null ? null : discountOff,
        "price": price == null ? null : price,
        "productImage": productImage == null ? null : productImage,
      };
}
