import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/model/categoriesModel.dart';
import 'package:foodistaan_restuarant/model/productModel.dart';

class Products with ChangeNotifier {
  List<Product>? product;

  Products({
    this.product,
  });

  List<Product> get products {
    return [...product!];
  }

  factory Products.fromJson(String str) => Products.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Products.fromMap(Map<String, dynamic> json) => Products(
        product: json["Product"] == null
            ? null
            : List<Product>.from(
                json["Product"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Product": product == null
            ? null
            : List<dynamic>.from(product!.map((x) => x.toMap())),
      };

// Fetching productItem from the firebase
  Future<void> fetchAndSetProductItems() async {
    try {
      final List<Product> loadedProductItems = [];
      final extractedData = [
        Product(
          id: "0",
          name: "Box Packaging",
          productImage:
              "https://cdn.pixabay.com/photo/2016/07/12/09/31/package-1511683_960_720.jpg",
          quantity: "5 x25 pack",
          discountOff: 5,
          categorie: Categorie(
            name: "packaging",
            id: "222",
            categorieImage:
                "https://cdn.pixabay.com/photo/2019/08/11/16/17/carton-4399301_960_720.png",
          ),
          description: '',
          price: 70.0,
        ),
        Product(
          id: "1",
          name: "Olive Oil",
          productImage:
              "https://cdn.pixabay.com/photo/2014/12/21/23/59/olive-oil-576533_960_720.png",
          quantity: "4 x50 ml",
          discountOff: 18,
          categorie: Categorie(
            name: "oil",
            id: "333",
            categorieImage:
                "https://cdn.pixabay.com/photo/2013/07/13/12/33/oil-159855_960_720.png",
          ),
          description: '',
          price: 120.0,
        ),
        Product(
          id: "2",
          name: "Brown Bread",
          productImage:
              "https://cdn.pixabay.com/photo/2018/03/21/05/24/bread-3245615_960_720.jpg",
          quantity: "5 x100 g",
          discountOff: 0,
          categorie: Categorie(
              name: "bread",
              id: "444",
              categorieImage:
                  "https://cdn.pixabay.com/photo/2017/10/18/16/44/bread-2864703_960_720.jpg"),
          description: '',
          price: 150.0,
        ),
        Product(
          id: "3",
          name: "Coconut Oil",
          productImage:
              "https://cdn.pixabay.com/photo/2017/09/28/06/50/oil-discharge-2794477_960_720.jpg",
          quantity: "3 x10 ml",
          discountOff: 10,
          categorie: Categorie(
            name: "oil",
            id: "333",
            categorieImage:
                "https://cdn.pixabay.com/photo/2013/07/13/12/33/oil-159855_960_720.png",
          ),
          description: '',
          price: 50.0,
        ),
        Product(
          id: "4",
          name: "Lactose Free Milk",
          productImage:
              "https://cdn.pixabay.com/photo/2016/12/06/18/27/cereal-1887237_960_720.jpg",
          quantity: "2 x500 ml",
          discountOff: 15,
          categorie: Categorie(
            name: "milk",
            id: "555",
            categorieImage:
                "https://cdn.pixabay.com/photo/2016/05/02/12/30/milk-1367171_960_720.jpg",
          ),
          description: '',
          price: 650.0,
        ),
        Product(
          id: "5",
          name: "Hot Ketchup",
          productImage:
              "https://cdn.pixabay.com/photo/2015/01/30/08/52/ketchup-617231_960_720.jpg",
          quantity: "1 x75 ml",
          discountOff: 0,
          categorie: Categorie(
            name: "ketchup",
            id: "666",
            categorieImage:
                "https://cdn.pixabay.com/photo/2017/10/18/16/44/bread-2864703_960_720.jpg",
          ),
          description: '',
          price: 95.0,
        ),
      ];
      if (extractedData == null) {
        return;
      }
      // print(extractedData.toString());
      extractedData.forEach((element) {
        loadedProductItems.add(element);
      });
      product = loadedProductItems.reversed.toList();
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  // This Function take Category Name As argument And returns The List Of That Category
  //
  List<Product> categoryItems(selectedValue) {
    // print('Its :-$selectedValue');
    if (selectedValue.toLowerCase() == "all") {
      return products;
    } else if (selectedValue.isNotEmpty && selectedValue != null) {
      return products
          .where((element) => element.categorie!.name.startsWith(selectedValue))
          .toList();
    }
    // notifyListeners();
    return [];
  }

  // This function is use to calculate discount Price after applying discount
  discountPriceCalculator(price, discountOff) {
    double newPrice = price - ((price / 100) * discountOff);
    return newPrice;
  }
}
