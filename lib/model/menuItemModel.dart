import 'dart:convert';

class MenuItem {
  final String id;
  final String title;
  final String cuisine;
  final String description;
  final String maxQuantity;
  final bool veg;
  final int discountOff;
  final double price;
  final String image;

  MenuItem({
    required this.id,
    required this.title,
    required this.cuisine,
    required this.description,
    required this.maxQuantity,
    required this.veg,
    required this.discountOff,
    required this.price,
    required this.image,
  });

//     final menuItems = menuItemsFromMap(jsonString);
  factory MenuItem.fromJson(String str) => MenuItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MenuItem.fromMap(Map<String, dynamic> json) => MenuItem(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        cuisine: json["cuisine"] == null ? null : json["cuisine"],
        description: json["description"] == null ? null : json["description"],
        maxQuantity: json["maxQuantity"] == null ? null : json["maxQuantity"],
        veg: json["veg"] == null ? null : json["veg"],
        discountOff: json["discountOff"] == null ? null : json["discountOff"],
        price: json["price"] == null ? null : json["price"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "cuisine": cuisine == null ? null : cuisine,
        "description": description == null ? null : description,
        "maxQuantity": maxQuantity == null ? null : maxQuantity,
        "veg": veg == null ? null : veg,
        "discountOff": discountOff == null ? null : discountOff,
        "price": price == null ? null : price,
        "image": image == null ? null : image,
      };
}
