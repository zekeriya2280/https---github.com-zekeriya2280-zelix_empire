import 'package:zelix_empire/models/product.dart';

class Country {
  final String name;
  int level; // Ülkenin seviyesi
  Map<Product, int> requiredProducts; // Ülkenin istediği ürünler ve miktarları

  Country({
    required this.name,
    required this.level,
    required this.requiredProducts,
  });

  // Ürünleri teslim etme ve kontrol etme
  bool deliverProducts(Map<Product, int> deliveredProducts) {
    for (var entry in deliveredProducts.entries) {
      if (requiredProducts.containsKey(entry.key)) {
        requiredProducts[entry.key] = requiredProducts[entry.key]! - entry.value;
        if (requiredProducts[entry.key]! <= 0) {
          requiredProducts.remove(entry.key);
        }
      }
    }

    // Tüm gerekli ürünler sağlanmışsa ülke seviye atlar
    if (requiredProducts.isEmpty) {
      levelUp();
      return true;
    }
    return false;
  }

  // Ülke seviye atladığında yeni ürün talepleri olur
  void levelUp() {
    level += 1;
    print('$name has leveled up to level $level');
    // Yeni ürün taleplerini ekleyebiliriz
    requiredProducts = getNewProductRequirements();
  }

  // Yeni ürün taleplerini belirleme (örnek)
  Map<Product, int> getNewProductRequirements() {
    // Her seviye için yeni ürün talepleri tanımlanabilir
    return {
      Product(name: 'Advanced Product', basePurchasePrice: 200, baseSalePrice: 300, duration: 5, level: level): 10,
    };
  }
}
