import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/model/menuItemModel.dart';

class MenuItems with ChangeNotifier {
  List<MenuItem> _items = [
    // MenuItem(
    //   id: "farm-house",
    //   title: "Farm House",
    //   cuisine: "pizza",
    //   description:
    //       "A pizza that goes ballistic on veggies! Check out this mouth watering overload of crunchy, crisp capsicum, succulent mushrooms and fresh tomatoes",
    //   maxQuantity: "5",
    //   veg: false,
    //   discountOff: 5,
    //   price: 99.0,
    //   image: "https://www.dominos.co.in/files/items/Farmhouse.jpg",
    // ),
    // MenuItem(
    //   id: "margherita",
    //   title: "Margheita",
    //   cuisine: "pizza",
    //   description:
    //       "A hugely popular margherita, with a deliciously tangy single cheese topping",
    //   maxQuantity: "5",
    //   veg: true,
    //   discountOff: 0,
    //   price: 99.0,
    //   image: "https://www.dominos.co.in/files/items/Margherit.jpg",
    // ),
  ];

  MenuItems(this._items);

  List<MenuItem> get items {
    return [..._items];
  }

  MenuItem findById(String id) {
    return _items.firstWhere((item) => item.id == id);
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
          price: 99.0,
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
      ];
      if (extractedData == null) {
        return;
      }
      print(extractedData.toString());
      extractedData.forEach((element) {
        loadedMenuItems.add(
          MenuItem(
              id: element.id,
              title: element.title,
              cuisine: element.cuisine,
              description: element.description,
              maxQuantity: element.maxQuantity,
              veg: element.veg,
              price: element.price,
              discountOff: element.discountOff,
              image: element.image),
        );
      });
      _items = loadedMenuItems.reversed.toList();
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

//this function adds new menuItem
  Future<void> addMenuItem(MenuItem menuItem) async {
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
      _items.add(newMenuItem);

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
    final menuIndex = _items.indexWhere((menu) => menu.id == id);
    try {
      if (menuIndex >= 0) {
        _items[menuIndex] = updateMenuItem;
        notifyListeners();
        // print('....Product Updated...${updateMenuItem}');
      } else {
        print('....Not Update...');
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
