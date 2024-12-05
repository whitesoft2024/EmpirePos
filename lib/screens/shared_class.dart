import 'package:flutter/material.dart';

class QuantityNotifier extends ChangeNotifier {
  String _quantity = '0';
  String _discount = '0';
  String _price = '0';

  String get quantity => _quantity;
  String get discount => _discount;
  String get price => _price;

  void updateProductQuantity(String newQuantity) {
    _quantity = newQuantity;
    notifyListeners();
  }

  void updateProductDiscount(String newDiscount) {
    _discount = newDiscount;
    notifyListeners();
  }

  void updateProductPrice(int productIndex, String newPrice) {
    _price = newPrice;
    notifyListeners();
  }

  void deleteLastCharacter() {
    if (_quantity.isNotEmpty && _quantity != "0") {
      _quantity = _quantity.substring(0, _quantity.length - 1);
      if (_quantity.isEmpty) _quantity = '0';
      notifyListeners();
    }
  }

  void reset() {
    _quantity = '0';
    _discount = '0';
    _price = '0';
    notifyListeners();
  }
}
