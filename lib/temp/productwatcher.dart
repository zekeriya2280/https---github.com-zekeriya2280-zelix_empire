import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zelix_empire/models/product2.dart';
import 'package:zelix_empire/temp/productadapter.dart';
import 'package:flutter/services.dart' show AssetBundle, rootBundle;

class ProductWatcher {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //final String filePath;
  late Box<Product2> _productBox;

  ProductWatcher();

  // Hive ve Firebase başlangıç
  Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProductAdapter());
    _productBox = await Hive.openBox<Product2>('products');
    await _syncWithFirebase();
  }

  // Firebase'deki ürünleri Hive ile senkronize et
  Future<void> _syncWithFirebase() async {
    final snapshot = await _firestore.collection('products2').get();
    for (var doc in snapshot.docs) {
      final product = Product2.fromJson(doc.data());
      if (!_productBox.values.any((p) => p.name == product.name)) {
        await _productBox.put(product.name, product);
      }
    }
    print("Firebase ürünleri Hive ile senkronize edildi.");
  }

  // JSON dosyasını oku ve işle
  Future<void> _processJsonFile() async {
    try {
      final content = await rootBundle.loadString("assets/products.json");
      print('Loaded products.json: $content');
      final jsonList = jsonDecode(content) as List;
      print(jsonList.length);
      for (var json in jsonList) {
        final product = Product2.fromJson(json);
        print("Yeni ürün okundu: ${product.name}");
        if (product.isValid() && !_productBox.containsKey(product.name)) {
          _productBox.put(product.name, product);
          await _firestore.collection('products').add(product.toJson());
          print("Yeni ürün Firebase'e eklendi: ${product.name}");
        }
      }
    } catch (e) {
      print("Hata: $e");
    }
  }

  // Dosya değişikliklerini izle
  Future<void> watchFile() async {
    final file = File(
        '${(await getApplicationDocumentsDirectory()).path}/products.json');

    final assetStream = rootBundle.loadString('assets/products.json');

    final fileStream = file.openRead();

    Stream<List<int>> differences = const Stream.empty();
    Future<String> currentStream = assetStream;

    // Watch for changes to the copied file
    file.watch(events: FileSystemEvent.modify).listen((event) async {
      if (event is FileSystemModifyEvent) {
        final newStream = file.openRead();

        differences = ZipStream.zip2(
          Stream.fromFuture(currentStream),
          newStream,
          (a, b) => a != b ? [int.parse(a)] : const <int>[],
        );

        try {
          final newContent = await differences.cast<String>().join();
          if (newContent.isNotEmpty) {
            await _processJsonFile();
          }
          currentStream =
              newStream.transform(utf8.decoder).join().then((value) =>
            currentStream = Future.value(value)
          );
        } on Exception catch (e) {
          print("Error: $e");
        }
      }
    });
  }
}
