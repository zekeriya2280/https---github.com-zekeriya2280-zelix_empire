import 'package:zelix_empire/models/product.dart';

class Building {
  final String name;
  final double purchaseCost; // Binanın satın alma maliyeti
  int level; // Binanın seviyesi
  double baseUpkeep; // Temel upkeep vergisi
  Product produces; // Bu bina hangi ürünü üretiyor

  Building({
    required this.name,
    required this.purchaseCost,
    required this.level,
    required this.baseUpkeep,
    required this.produces,
  });

  // Binanın upkeep vergisini hesapla (seviye ile orantılı)
  double get currentUpkeep => baseUpkeep * level;

  // Bina seviyesini arttır
  void levelUp() {
    level += 1;
    print('$name leveled up to level $level');
  }
}
