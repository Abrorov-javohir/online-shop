import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  final String imageUrl;
  final String name;
  final String type;
  final double price;
  final double rating;
  bool isLiked;
  int quantity;

  Product({
    required this.imageUrl,
    required this.name,
    required this.type,
    required this.price,
    required this.rating,
    this.isLiked = false, // Default value
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'type': type,
      'price': price,
      'rating': rating,
      'isLiked': isLiked,
      'quantity': quantity,
    };
  }

  factory Product.fromJson(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      imageUrl: data['imageUrl'] ?? '',
      name: data['name'] ?? '',
      type: data['type'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      rating: (data['rating'] ?? 0).toDouble(),
      isLiked: data['isLiked'] ?? false,
      quantity: data['quantity'] ?? 1,
    );
  }
}

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [
    Product(
      imageUrl:
          'https://www.ikea.com/us/en/images/products/isnalen-led-work-lamp-red-brass-color__1053465_pe847031_s5.jpg?f=s',
      name: 'ISNALEN LED',
      type: 'LAMP',
      price: 100.00,
      rating: 4.0,
    ),
    Product(
      imageUrl:
          'https://hebstreit.com/cdn/shop/products/a-painting-of-a-plant-with-red-berries-and-leaves-820710g1.jpg?v=1705925616&width=1946',
      name: 'Painting berry plant',
      type: 'Paint',
      price: 120.00,
      rating: 4.5,
    ),
    Product(
      imageUrl: 'https://virtusnet.de/common/images/8526G.jpg',
      name: 'Double wall shelf',
      type: 'Decoration',
      price: 80.00,
      rating: 3.5,
    ),
    Product(
      imageUrl:
          'https://images.herzindagi.info/image/2021/Dec/india-decorative-plants.jpg',
      name: 'Decorative Plants',
      type: 'Decoration',
      price: 80.00,
      rating: 3.5,
    ),
  ];

  List<Product> get products => _products;

  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

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
