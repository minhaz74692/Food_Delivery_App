import 'package:flutter/material.dart';
import 'package:remote_kitchen_quiz/models/menu_item.dart';

class ItemBloc extends ChangeNotifier {
  int count = 0;
  int price = 0;
  List<MenuItem> itemListInCart = [];

  void addItemToCart(MenuItem x) {
    itemListInCart.add(x);
    notifyListeners();
  }

  void removeItemFromCart(MenuItem x) {
    itemListInCart.remove(x);
    notifyListeners();
  }

  void clearCart() {
    itemListInCart.clear();
    notifyListeners();
  }

  void removeThisItemFromCart(MenuItem x) {
    itemListInCart.removeWhere((product) => product.id == x.id);
    notifyListeners();
  }

  void increment() {
    count++;
    notifyListeners();
  }

  void decrement() {
    if (count > 0) {
      count--;
      notifyListeners();
    }
  }

  void removePrice(int x) {
    if (price > x) {
      price = price - x;
      notifyListeners();
    }
  }

  void addPrice(int x) {
    price = price + x;
    notifyListeners();
  }
}
