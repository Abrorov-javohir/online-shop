import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uy_ishi_3/model/product.dart';

class FirebaseProductService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Product>> getProducts() {
    return _firestore
        .collection('shop')
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((DocumentSnapshot doc) {
        return Product.fromDocument(doc);
      }).toList();
    });
  }

  Future<void> addProduct(
      String imageUrl, String name, double price, double rating) async {
    await _firestore.collection('shop').add({
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'rating': rating,
      'isLiked': false,
    });
  }
}
