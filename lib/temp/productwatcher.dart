import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zelix_empire/models/product2.dart';
import 'package:flutter/services.dart' show rootBundle;

class ProductWatcher {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Product2> products = [];
  ProductWatcher();

  // Hive ve Firebase başlangıç
  //Future<void> initialize() async {
  //  await _syncWithFirebase();
  //}
//
  //// Firebase'deki ürünleri Hive ile senkronize et
  //Future<List<Product2>> _syncWithFirebase() async {
  //  final querySnapshot = await _firestore.collection('products2').get();
  //  for (var document in querySnapshot.docs) {
  //    products.add(Product2.fromJson(document.data()));
  //  }
//
  //  return products;
  //}
  

  // JSON dosyasını oku ve işle
  /// Processes the JSON file at [filePath] by reading its contents,
  /// decoding the JSON, and then iterating over the list of products.
  /// If a product is valid and not already in the Hive box, it is added
  /// to the box and to the Firebase 'products' collection.
Future<void> _processJsonFile() async {
  try {
    print("Starting to process JSON file.");

    // Load the JSON file
    final content = await rootBundle.loadString("assets/products.json");
    print('Loaded products.json: $content');

    // Decode the JSON
    final jsonList = jsonDecode(content) as List;
    print("Decoded JSON list has ${jsonList.length} elements");

    // Iterate over the list of products
    for (var json in jsonList) {
      // Create a Product2 object from the JSON
      final product = Product2.fromJson(json);
      print("Processed product: ${product.name}");

      // Check if the product is valid and not already in the Firebase 'products2' collection
      final querySnapshot = await _firestore.collection('products2').where('name', isEqualTo: product.name).get();
      if (product.isValid() && querySnapshot.docs.isEmpty) {
        print("Product is valid and not already in Firebase: ${product.name}");

        // Add the product to the Firebase 'products2' collection
        await _firestore.collection('products2').add(product.toJson());
        print("Added product to Firebase: ${product.name}");
      } else {
        print("Product is invalid or already exists in Firebase: ${product.name}");
      }
    }
  } catch (e) {
    print("Error processing JSON file: $e");
  } finally {
    print("Finished processing JSON file.");
  }
}

  // Dosya değişikliklerini izle
/// Watches the file at [filePath] for changes and processes the file as a JSON
/// list of products whenever the file changes.
///
/// If the file does not exist, it is copied from the assets directory to the
/// documents directory.
///
/// The file is processed by adding any valid and not already existing products
/// to the Firebase 'products2' collection.
///
/// If any errors occur during processing, they are printed to the console.
Future<void> watchFile(String filePath) async {
  final file = File(filePath);

  try {
    // Copy the file from assets to the documents directory if it does not exist
    //if (!file.existsSync()) {
      final content = await rootBundle.loadString('assets/products.json');
      print("${content}CONTENT");
      await file.writeAsString(content);

      print('Copied products.json from assets to $filePath');
    //}

    print('Starting to watch $filePath for changes...');

    // Watch for changes to the copied file
    final newContent = await file.readAsString();
    print('Initial content: "${newContent.substring(0, min(100, newContent.length))}..."');
    file
        .watch(events: FileSystemEvent.modify)
        .listen((event) async {
          print('Event: $event');
      if (event is FileSystemModifyEvent) {
        print('Detected change in $filePath');
        try {
          
          if (newContent != await file.readAsString()) {
            print('Content of $filePath has changed');
            print('Old content: "${(await file.readAsString()).substring(0, min(100, (await file.readAsString()).length))}..."\nNew content: "${newContent.substring(0, min(100, newContent.length))}..."');

            try {
              // Process JSON file
              print('Processing JSON file...');
              await _processJsonFile();
              print('Finished processing JSON file. Updating Firebase with the latest products...');

              // Update Firebase with the latest products
              await _updateFirebaseWithLatestProducts();
              print('Finished updating Firebase with the latest products.');
            } catch (e) {
              print('Error processing JSON file: $e');
            }
          } else {
            print('Content of $filePath has not changed');
          }
        } catch (e) {
          print('Error reading file: $e');
        }
      } else {
        print('Received unexpected event: $event');
      }
    }, onError: (e) {
      print('Error watching file: $e');
    });
  } catch (e) {
    print('Error initializing file watch: $e');
  }
}

Future<void> _updateFirebaseWithLatestProducts() async {
  try {
    print('Fetching latest products from Firebase and JSON file...');

    // Fetch both latest products from Firebase and JSON file concurrently
    final querySnapshotFuture = _firestore.collection('products2').get();
    final jsonContentFuture = rootBundle.loadString("assets/products.json");

    // Wait for both futures to complete
    final querySnapshot = await querySnapshotFuture;
    final jsonContent = await jsonContentFuture;

    print('Finished fetching latest products from Firebase and JSON file. Decoding JSON...');

    // Decode JSON and map to Product2 objects
    final jsonList = jsonDecode(jsonContent) as Map<String, dynamic>;
    final productsFromJson = {
      for (var json in jsonList.values) Product2.fromJson(json).name: Product2.fromJson(json)
    };

    print('Finished decoding JSON. Mapping latest products from Firebase to a dictionary for quick lookup...');

    // Map latest products from Firebase to a dictionary for quick lookup
    final latestProducts = {
      for (var doc in querySnapshot.docs) Product2.fromJson(doc.data()).name: doc.reference
    };

    print('Finished mapping latest products from Firebase to a dictionary for quick lookup. Determining which products need to be updated or added...');

    // Batch operations for better performance
    final batch = _firestore.batch();

    // Determine which products need to be updated or added
    for (var product in productsFromJson.values) {
      final currentDocRef = latestProducts[product.name];
      final currentDocSnapshot = currentDocRef != null ? await currentDocRef.get() : null;

      print('Processing product: ${product.name}');

      if (currentDocSnapshot == null ||
          Product2.fromJson(currentDocSnapshot.data() ?? {}).toJson() != product.toJson()) {
        if (currentDocRef != null) {
          print('Deleting outdated product: ${product.name}');
          batch.delete(currentDocRef);
        }
        print('Adding or updating product: ${product.name}');
        batch.set(_firestore.collection('products2').doc(product.name), product.toJson());
      }
    }

    print('Finished determining which products need to be updated or added. Committing all changes in a single batch...');

    // Commit all changes in a single batch
    await batch.commit();

    print('Finished committing all changes in a single batch.');
  } catch (e) {
    print("Error updating Firebase with latest products: $e");
  }
}
}
