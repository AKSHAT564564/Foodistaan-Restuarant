import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/model/productModel.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: "0",
      name: "Box Packaging",
      productImage:
          "https://cdn.pixabay.com/photo/2016/07/12/09/31/package-1511683_960_720.jpg",
      quantity: "5 x25 ml",
      discountOff: 5,
      categorie: "packaging",
      price: 70.0,
    ),
    Product(
      id: "1",
      name: "Olive Oil",
      productImage:
          "https://cdn.pixabay.com/photo/2014/12/21/23/59/olive-oil-576533_960_720.png",
      quantity: "4 x50 ml",
      discountOff: 18,
      categorie: "oil",
      price: 120.0,
    ),
    Product(
      id: "2",
      name: "Brown Bread",
      productImage:
          "https://cdn.pixabay.com/photo/2018/03/21/05/24/bread-3245615_960_720.jpg",
      quantity: "5 x100 g",
      discountOff: 0,
      categorie: "bread",
      price: 150.0,
    ),
    Product(
      id: "3",
      name: "Coconut Oil",
      productImage:
          "https://cdn.pixabay.com/photo/2017/09/28/06/50/oil-discharge-2794477_960_720.jpg",
      quantity: "3 x10 ml",
      discountOff: 10,
      categorie: "oil",
      price: 50.0,
    ),
    Product(
      id: "4",
      name: "Lactose Free Milk",
      productImage:
          "https://cdn.pixabay.com/photo/2016/12/06/18/27/cereal-1887237_960_720.jpg",
      quantity: "2 x500 ml",
      discountOff: 15,
      categorie: "milk",
      price: 650.0,
    ),
    Product(
      id: "5",
      name: "Hot Ketchup",
      productImage:
          "https://cdn.pixabay.com/photo/2015/01/30/08/52/ketchup-617231_960_720.jpg",
      quantity: "1 x75 ml",
      discountOff: 0,
      categorie: "ketchup",
      price: 95.0,
    ),
  ];

  Products(this._items);

  List<Product> get items {
    return [..._items];
  }

  // This Function take Category Name As argument And returns The List Of That Category
  //
  List<Product> categoryItems(selectedValue) {
    print('Its :-$selectedValue');
    if (selectedValue.toLowerCase() == "all") {
      return items;
    } else if (selectedValue.isNotEmpty && selectedValue != null) {
      return _items
          .where((element) => element.categorie.startsWith(selectedValue))
          .toList();
    }
    notifyListeners();
    return [];
  }

// This function is use to calculate discount Price after applying discount
  discountPriceCalculator(price, discountOff) {
    double newPrice = price - ((price / 100) * discountOff);
    return newPrice;
  }
}
