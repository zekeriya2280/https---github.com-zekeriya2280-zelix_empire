import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:zelix_empire/models/product2.dart';

class ProductAdapter extends TypeAdapter<Product2> {
  @override
  final int typeId = 0; // unique type id for Product2

  @override
  Product2 read(BinaryReader reader) {
    // deserialize Product2 from BinaryReader
    return Product2.fromJson(jsonDecode(reader.readString()));
  }

  @override
  void write(BinaryWriter writer, Product2 obj) {
    // serialize Product2 to BinaryWriter
    writer.writeString(jsonEncode(obj.toJson()));
  }
}