import 'package:zelix_empire/models/building.dart';
import 'package:zelix_empire/models/product.dart';

class Factory {
  Map<String, int> stock; // Stoktaki hammaddeler (isim ve miktar)
  List<Building> buildings; // Sahip olunan binalar
  double budget; // Fabrikanın bütçesi

  Factory({
    required this.stock,
    required this.buildings,
    required this.budget,
  });

  // Bina satın alma fonksiyonu
  bool purchaseBuilding(Building building) {
    if (budget >= building.purchaseCost) {
      budget -= building.purchaseCost;
      buildings.add(building);
      print('${building.name} purchased for \$${building.purchaseCost.toStringAsFixed(2)}');
      print('New budget: \$${budget.toStringAsFixed(2)}');
      return true;
    } else {
      print('Not enough budget to purchase ${building.name}');
      return false;
    }
  }

  // Ürün satın alma fonksiyonu
  bool purchaseProduct(Product product, int quantity) {
    double totalCost = product.currentPurchasePrice * quantity;
    if (budget >= totalCost) {
      budget -= totalCost;
      stock[product.name] = (stock[product.name] ?? 0) + quantity;
      print('$quantity ${product.name} purchased for \$${totalCost.toStringAsFixed(2)}');
      print('New budget: \$${budget.toStringAsFixed(2)}');
      return true;
    } else {
      print('Not enough budget to purchase ${product.name}');
      return false;
    }
  }

  // Ürün satma fonksiyonu
  bool sellProduct(Product product, int quantity) {
    if (stock[product.name] != null && stock[product.name]! >= quantity) {
      double totalRevenue = product.currentSalePrice * quantity;
      stock[product.name] = stock[product.name]! - quantity;
      budget += totalRevenue;
      print('$quantity ${product.name} sold for \$${totalRevenue.toStringAsFixed(2)}');
      print('New budget: \$${budget.toStringAsFixed(2)}');
      return true;
    } else {
      print('Not enough stock to sell ${product.name}');
      return false;
    }
  }

  // Üretim yapma ve upkeep vergisi uygula
// bool produceWithBuilding(Building building) {
//   double upkeepCost = building.currentUpkeep;
//   if (budget >= upkeepCost) {
//     budget -= upkeepCost;
//     print('Upkeep of \$${upkeepCost.toStringAsFixed(2)} paid for ${building.name}');
//
//     Product product = building.produces;
//     if (product.requiredMaterials != null) {
//       for (var material in product.requiredMaterials!.entries) {
//         if (stock[material.key] == null || stock[material.key]! < material.value) {
//           print('Not enough ${material.key} to produce ${product.name}');
//           return false;
//         }
//       }
//
//       for (var material in product.requiredMaterials!.entries) {
//         stock[material.key] = stock[material.key]! - material.value;
//       }
//
//       stock[product.name] = (stock[product.name] ?? 0) + 1;
//       print('${product.name} produced successfully by ${building.name}!');
//       return true;
//     } else {
//       stock[product.name] = (stock[product.name] ?? 0) + 1;
//       print('${product.name} produced successfully by ${building.name}!');
//       return true;
//     }
//   } else {
//     print('Not enough budget to cover upkeep for ${building.name}');
//     return false;
//   }
// }
//
  // Bina seviyesini artırma
  void levelUpBuilding(Building building) {
    building.levelUp();
  }
}
