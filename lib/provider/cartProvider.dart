import 'package:flutter/foundation.dart';
import 'package:foodistaan_restuarant/model/cartModel.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

//single items in the cart
  int cartSingleCount(String productId) {
    var singleQuantity = 0;

    if (_cartItems.containsKey(productId)) {
      _cartItems.forEach((key, cartItem) {
        if (cartItem.id == productId) {
          singleQuantity = cartItem.quantity;
        }
      });
    }

    // notifyListeners();
    return singleQuantity;
  }

//total items in the cart
  int get cartItemCount {
    return _cartItems.length;
    //  return _cartItems == null ? 0 : _cartItems.length;
  }

  //total amount in the cart
  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

// adding items to the cart
  void addItem(
    String productId,
    double price,
    String imageUrl,
    String title,
  ) {
    if (_cartItems.containsKey(productId)) {
      // change quantity...
      _cartItems.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          imageUrl: existingCartItem.imageUrl,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartItem(
          // id: DateTime.now().toString(),
          id: productId,
          title: title,
          imageUrl: imageUrl,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  // remove particular item from cart
  void removeItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  // remove single item from the cart
  void removeSingleItem(String productId) {
    if (!_cartItems.containsKey(productId)) {
      return;
    }
    if (_cartItems[productId]!.quantity > 1) {
      _cartItems.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                imageUrl: existingCartItem.imageUrl,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity - 1,
              ));
    } else {
      _cartItems.remove(productId);
    }
    notifyListeners();
  }

  // --- to clear all items from the cart -----
  void clear() {
    _cartItems = {};
    notifyListeners();
  }
}
