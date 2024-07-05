import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [];
  final List<Product> _cartItems = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProductProvider() {
    _fetchProductsFromFirestore();
  }

  List<Product> get products => _products;
  List<Product> get cartItems => _cartItems;

  Future<void> _fetchProductsFromFirestore() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('shop').get();
      _products.clear();
      for (var doc in snapshot.docs) {
        _products.add(Product.fromDocument(doc));
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  void toggleLikeStatus(Product product) {
    product.isLiked = !product.isLiked;
    notifyListeners();
  }

  void sortProducts(String criterion) {
    switch (criterion) {
      case 'Price':
        _products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Rating':
        _products.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Newest':
        // Implement sorting logic for newest
        break;
    }
    notifyListeners();
  }

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }
}
