import 'package:zelix_empire/models/building.dart';
import 'package:zelix_empire/models/product.dart';

class Users {
  final String id;
  final String nickname;
  final String email;
  List<Product> products = [];
  List<Building> buildings = [];

  Users({required this.id, required this.nickname, required this.email , required this.buildings, required this.products});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nickname': nickname,
      'email': email,
      'buildings': buildings,
      'products': products
    };
  }

  factory Users.fromMap(Map<String, dynamic> material) {
    return Users(
      id: material['id'],
      nickname: material['nickname'],
      email: material['email'],
      buildings: List<Building>.from(material['buildings']),
      products: List<Product>.from(material['products']),
    );
  }
}