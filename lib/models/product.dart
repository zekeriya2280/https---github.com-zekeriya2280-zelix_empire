class Product {
  final String name;
  double basePurchasePrice; // Ürünün temel alış fiyatı
  double baseSalePrice; // Ürünün temel satış fiyatı
  final int duration; // Ürünün üretim süresi
  List<Map<String, dynamic>>? requiredMaterials; // Ürünün üretimi için gereken hammaddeler
  double demandindex;
  int level;
  

  Product({
    required this.name,
    required this.level,
    required this.basePurchasePrice,
    required this.baseSalePrice,
    required this.duration,
    required this.requiredMaterials,
    this.demandindex = 0.02, // Varsayılan enflasyon oranı %2
  });

  // Enflasyona göre alış fiyatını güncelle
  double get currentPurchasePrice => basePurchasePrice * (1 + demandindex);

  // Enflasyona göre satış fiyatını güncelle
  double get currentSalePrice => baseSalePrice * (1 + demandindex);

  factory Product.fromMap(Map<String, dynamic> material) {
    return Product(
      name: material['name'],
      basePurchasePrice: double.parse(material['purchasePrice'].toString()),
      baseSalePrice: double.parse(material['salePrice'].toString()),
      duration: int.parse(material['duration'].toString()),
      requiredMaterials: List<Map<String, dynamic>>.from(material['requiredMaterials']),
      demandindex: double.parse(material['demandindex'].toString()), 
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
      'demandindex': demandindex,
    };
  }
}
