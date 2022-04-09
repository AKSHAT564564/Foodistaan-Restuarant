import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/model/menuItemModel.dart';

class MenuItems with ChangeNotifier {
  List<MenuItem>? menuItem;

  MenuItems({
    this.menuItem,
  });

  List<MenuItem> get menuItems {
    return [...menuItem!];
  }

  factory MenuItems.fromJson(String str) => MenuItems.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MenuItems.fromMap(Map<String, dynamic> json) => MenuItems(
        menuItem: json["MenuItem"] == null
            ? null
            : List<MenuItem>.from(
                json["MenuItem"].map(
                  (x) => MenuItem.fromMap(x),
                ),
              ),
      );

  Map<String, dynamic> toMap() => {
        "MenuItem": menuItem == null
            ? null
            : List<dynamic>.from(menuItem!.map((x) => x.toMap())),
      };

  MenuItem findById(String id) {
    return menuItem!.firstWhere((item) => item.id == id);
  }

// Fetching menuItem from the firebase
  Future<void> fetchAndSetMenuItems() async {
    try {
      final List<MenuItem> loadedMenuItems = [];
      final extractedData = [
        MenuItem(
          id: "farm-house",
          title: "Farm House",
          cuisine: "pizza",
          description:
              "A pizza that goes ballistic on veggies! Check out this mouth watering overload of crunchy, crisp capsicum, succulent mushrooms and fresh tomatoes",
          maxQuantity: "5",
          veg: false,
          discountOff: 5,
          price: 97.0,
          image: "https://www.dominos.co.in/files/items/Farmhouse.jpg",
        ),
        MenuItem(
          id: "margherita",
          title: "Margheita",
          cuisine: "pizza",
          description:
              "A hugely popular margherita, with a deliciously tangy single cheese topping",
          maxQuantity: "5",
          veg: true,
          discountOff: 0,
          price: 99.0,
          image: "https://www.dominos.co.in/files/items/Margherit.jpg",
        ),
        MenuItem(
          id: "farm-house1",
          title: "Farm House1",
          cuisine: "pizza",
          description:
              "A pizza that goes ballistic on veggies! Check out this mouth watering overload of crunchy, crisp capsicum, succulent mushrooms and fresh tomatoes",
          maxQuantity: "5",
          veg: false,
          discountOff: 5,
          price: 97.0,
          image: "https://www.dominos.co.in/files/items/Farmhouse.jpg",
        ),
        MenuItem(
          id: "margherita1",
          title: "Margheita1",
          cuisine: "pizza",
          description:
              "A hugely popular margherita, with a deliciously tangy single cheese topping",
          maxQuantity: "5",
          veg: true,
          discountOff: 0,
          price: 99.0,
          image: "https://www.dominos.co.in/files/items/Margherit.jpg",
        ),
        MenuItem(
          id: "farm-house2",
          title: "Farm House2",
          cuisine: "pizza",
          description:
              "A pizza that goes ballistic on veggies! Check out this mouth watering overload of crunchy, crisp capsicum, succulent mushrooms and fresh tomatoes",
          maxQuantity: "5",
          veg: false,
          discountOff: 5,
          price: 97.0,
          image: "https://www.dominos.co.in/files/items/Farmhouse.jpg",
        ),
        MenuItem(
          id: "margherita2",
          title: "Margheita2",
          cuisine: "pizza",
          description:
              "A hugely popular margherita, with a deliciously tangy single cheese topping",
          maxQuantity: "5",
          veg: true,
          discountOff: 0,
          price: 99.0,
          image: "https://www.dominos.co.in/files/items/Margherit.jpg",
        ),
      ];
      if (extractedData == null) {
        return;
      }
      // print(extractedData.toString());
      extractedData.forEach((element) {
        loadedMenuItems.add(element);
      });
      menuItem = loadedMenuItems.reversed.toList();
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

//this function adds new menuItem
  Future<void> addMenuItem(MenuItem menuItem) async {
    // print(menuItem.toJson());
    try {
      final newMenuItem = MenuItem(
        id: menuItem.id,
        title: menuItem.title,
        cuisine: menuItem.cuisine,
        description: menuItem.description,
        maxQuantity: menuItem.maxQuantity,
        veg: menuItem.veg,
        discountOff: menuItem.discountOff,
        price: menuItem.price,
        image: menuItem.image,
      );

      menuItems.add(newMenuItem);
      print(menuItems.length);
      notifyListeners();
    }
    // if we get an error during post we catch the error
    // and execute accordingly
    catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateMenuItem(String id, MenuItem updateMenuItem) async {
    final menuIndex = menuItem?.indexWhere((menu) => menu.id == id);
    try {
      if (menuIndex! >= 0) {
        menuItem?[menuIndex] = updateMenuItem;
        notifyListeners();
        print('....Product Updated...${updateMenuItem.toJson()}');
      } else {
        print('....Not Update...');
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
