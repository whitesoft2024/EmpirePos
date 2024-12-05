import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../stoke_view.dart';

class ProductProvider with ChangeNotifier {
  final Box<Item> _favoritesBox = Hive.box<Item>('favoriteProducts');
  final List<Item> _selectedProducts = [];
  late List<Item> _favoriteProducts;
  Item? _selectedProduct;

  ProductProvider() {
    _favoriteProducts = _favoritesBox.values.toList();
  }

  // Getter for selected products
  List<Item> get selectedProducts => _selectedProducts;

  // Getter for favorite products
  List<Item> get favoriteProducts => _favoriteProducts;
  Item? get selectedProduct => _selectedProduct;

  // Add a product to selected products
  void addProduct(Item product) {
    if (!_selectedProducts.any((item) => item.id == product.id)) {
      _selectedProducts.add(product);
      notifyListeners();
    }
  }

  // Remove a product from selected products
  void removeProduct(Item product) {
    _selectedProducts.removeWhere((item) => item.id == product.id);
    notifyListeners();
  }

  // Clear all selected products
  void clearProducts() {
    _selectedProducts.clear();
    notifyListeners();
  }

  void removeProductFromSelected(Item product) {
    selectedProducts.remove(product);
    notifyListeners(); // Notify listeners to update the UI
  }


  // Add a product to favorites or remove it if already in favorites (toggle logic)
  void toggleFavorite(Item product) {
    if (isFavorite(product)) {
      _favoriteProducts.removeWhere((favItem) => favItem.id == product.id);
      _favoritesBox.delete(product.id);
    } else {
      _favoriteProducts.add(product);
      _favoritesBox.put(product.id, product);
    }
    notifyListeners();
  }

  // Check if a product is in favorites
  bool isFavorite(Item product) {
    return _favoriteProducts.any((favItem) => favItem.id == product.id);
  }

  void updateSelectedProduct(Item updatedProduct) {
    int index = selectedProducts.indexWhere((item) => item.id == updatedProduct.id);
    if (index != -1) {
      selectedProducts[index] = updatedProduct;
      notifyListeners();
    }
  }


  // Select a product
  void selectProduct(Item product) {
    _selectedProduct = product;
    notifyListeners();
  }

  // Update quantity
  void updateQuantity(String quantity) {
    if (_selectedProduct != null) {
      _selectedProduct!.quantity = quantity;
      notifyListeners();
    }
  }

  // Update discount
  void updateDiscount(String discount) {
    if (_selectedProduct != null) {
      _selectedProduct!.discount = discount;
      notifyListeners();
    }
  }

  // Update price
  void updatePrice(String price) {
    if (_selectedProduct != null && price.isNotEmpty) {
      // If the selected product has an updated price, set that as the price
      _selectedProduct!.price = price;
      notifyListeners();
    }
  }

}
