class Product {
  final String name;
  double basePurchasePrice; // Ürünün temel alış fiyatı
  double baseSalePrice; // Ürünün temel satış fiyatı
  final int duration; // Ürünün üretim süresi
  final List<Map<String, int>>? requiredMaterials; // Ürünün üretimi için gereken hammaddeler
  double inflation; // Ürünün enflasyon oranı

  Product({
    required this.name,
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
      basePurchasePrice: double.parse(material['basePurchasePrice']),
      baseSalePrice: double.parse(material['baseSalePrice']),
      duration: int.parse(material['duration']),
      requiredMaterials: List<Map<String, int>>.from(material['rinflation']),
      inflation: double.parse(material['requaredMaterials']),
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
