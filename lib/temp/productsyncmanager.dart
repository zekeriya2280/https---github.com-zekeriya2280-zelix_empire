import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zelix_empire/models/product.dart';

class ProductSyncManager extends StatefulWidget {
  const ProductSyncManager({super.key});
  Future<void> syncWithFirebase() async {
    final state = _ProductSyncManagerState();
    await state.syncWithFirebase();
  }

  @override
  State<ProductSyncManager> createState() => _ProductSyncManagerState();
}

class _ProductSyncManagerState extends State<ProductSyncManager> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Product> realproducts = [];
  final String jsonFilePath = 'assets/products.json';
  // Fetch JSON products
  Future<Map<String, Product>> fetchJsonProducts() async {
    final jsonString = await rootBundle.loadString(jsonFilePath);
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return jsonMap.map((key, value) => MapEntry(key, Product.fromMap(value)));
  }

  // Fetch Firebase products
  Future<Map<String, Product>> fetchFirebaseProducts() async {
    final firestore = _firestore;
    final collectionRef = firestore.collection('products2');
    final collectionRefreal = firestore.collection('products');

    // Check if collection exists
    final snapshot = await collectionRef.get();
    final snapshotreal = await collectionRefreal.get();
    if (snapshot.size == 0) {
      // Create collection and add products from JSON file
      final jsonString = await rootBundle.loadString('assets/products.json');
      final jsonData = jsonDecode(jsonString);
      
      for (var productData in jsonData) {
        await collectionRef.add(productData);
      }
    }

    // Fetch and return products
    //final snapshot = await collectionRef.get();
    for (var doc in snapshotreal.docs) {
      realproducts.add(Product.fromMap(doc.data()));
    }
    return {for (var doc in snapshot.docs) doc.id: Product.fromMap(doc.data())};
  }

  // Sync Firebase with JSON
  Future<void> syncWithFirebase() async {
    final jsonProducts = await fetchJsonProducts();
    final firebaseProducts = await fetchFirebaseProducts();

    if (!_areProductsEqual(jsonProducts, firebaseProducts)) {
      final batch = _firestore.batch();
      final collection = _firestore.collection('products2');

      // Delete existing products in Firebase
      for (var docId in firebaseProducts.keys) {
        batch.delete(collection.doc(docId));
      }

      // Add new products from JSON
      jsonProducts.forEach((key, product) {
        batch.set(collection.doc(key), product.toMap());
      });

      await batch.commit();
      print('Firebase successfully updated.');
    }
  }

  // Check if products are equal
  bool _areProductsEqual(Map<String, Product> jsonProducts,
      Map<String, Product> firebaseProducts) {
    if (jsonProducts.length != firebaseProducts.length) return false;

    for (var key in jsonProducts.keys) {
      if (!firebaseProducts.containsKey(key)) return false;
      if (jsonProducts[key]!.toMap().toString() !=
          firebaseProducts[key]!.toMap().toString()) {
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
