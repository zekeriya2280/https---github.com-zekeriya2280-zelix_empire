class Product {
  final String name;
  double basePurchasePrice; // Ürünün temel alış fiyatı
  double baseSalePrice; // Ürünün temel satış fiyatı
  final int duration; // Ürünün üretim süresi
  final List<String>? requiredMaterials; // Ürünün üretimi için gereken hammaddeler
  double inflation;
  int level;
  

  Product({
    required this.name,
    required this.level,
    required this.basePurchasePrice,
    required this.baseSalePrice,
    required this.duration,
    this.requiredMaterials,
    this.inflation = 0.02, // Varsayılan enflasyon oranı %2
  });

  // Enflasyona göre alış fiyatını güncelle
  double get currentPurchasePrice => basePurchasePrice * (1 + inflation);

  // Enflasyona göre satış fiyatını güncelle
  double get currentSalePrice => baseSalePrice * (1 + inflation);

  static Product fromMap(Map<String, dynamic> material) {
    return Product(
      name: material['name'],
      basePurchasePrice: double.parse(material['basePurchasePrice'].toString()),
      baseSalePrice: double.parse(material['salePurchasePrice'].toString()),
      duration: int.parse(material['duration'].toString()),
      requiredMaterials: List<String>.from(material['requiredMaterials']),
      inflation: double.parse(material['inflation'].toString()), 
      level: int.parse(material['level'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'base_purchase_price': basePurchasePrice,
      'base_sale_price': baseSalePrice,
      'duration': duration,
      'required_materials': requiredMaterials,
      'inflation': inflation,
    };
  }
}
