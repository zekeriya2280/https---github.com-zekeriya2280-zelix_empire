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
}
