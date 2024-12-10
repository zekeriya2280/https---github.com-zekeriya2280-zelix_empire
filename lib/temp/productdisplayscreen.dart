import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class ProductDisplayScreen extends StatelessWidget {
  final String jsonFilePath = 'assets/products.json';

  ProductDisplayScreen({super.key}) {
    // Start periodic sync every 10 seconds
   // _startPeriodicSync();
  }

  Future<void> startPeriodicSync()async {
    await Future.doWhile(() async {
      await _syncFirebaseWithJson();
      await Future.delayed(Duration(seconds: 1));
      return true;
    });
  }

  Future<Map<String, dynamic>> _fetchJsonFile() async {
    final jsonString = await rootBundle.loadString(jsonFilePath);
    return json.decode(jsonString);
  }

  Future<Map<String, dynamic>> _fetchFirebaseData() async {
    final snapshot = await FirebaseFirestore.instance.collection('products2').get();
    return {
      for (var doc in snapshot.docs) doc.id: doc.data(),
    };
  }

  Future<void> _syncFirebaseWithJson() async {
    final jsonProducts = await _fetchJsonFile();
    final firebaseProducts = await _fetchFirebaseData();

    // Check if JSON and Firebase data are equal
    if (!_areProductsEqual(jsonProducts, firebaseProducts)) {
      final batch = FirebaseFirestore.instance.batch();
      final collection = FirebaseFirestore.instance.collection('products2');

      // Delete all Firebase documents
      for (var docId in firebaseProducts.keys) {
        batch.delete(collection.doc(docId));
      }

      // Add all JSON products to Firebase
      jsonProducts.forEach((key, value) {
        batch.set(collection.doc(key), value as Map<String, dynamic>);
      });

      await batch.commit();
      print('Firebase successfully updated from JSON.');
    }
  }

  bool _areProductsEqual(Map<String, dynamic> jsonProducts, Map<String, dynamic> firebaseProducts) {
    return json.encode(jsonProducts) == json.encode(firebaseProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products Viewer')),
      body: Column(
        children: [
          // Top Half: products.json content
          Expanded(
            flex: 1,
            child: FutureBuilder<Map<String, dynamic>>(
              future: _fetchJsonFile(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final jsonContent = snapshot.data!;
                return _buildJsonViewer(jsonContent, 'products.json');
              },
            ),
          ),
          Divider(height: 1, color: Colors.grey),
          // Bottom Half: Firebase products content
          Expanded(
            flex: 1,
            child: FutureBuilder<Map<String, dynamic>>(
              future: _fetchFirebaseData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final firebaseContent = snapshot.data!;
                return _buildJsonViewer(firebaseContent, 'Firebase products2');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJsonViewer(Map<String, dynamic> content, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                JsonEncoder.withIndent('  ').convert(content),
                style: TextStyle(fontFamily: 'monospace'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
