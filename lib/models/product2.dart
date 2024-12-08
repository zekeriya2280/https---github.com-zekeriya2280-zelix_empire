class Product2 {
  final String name;
  final double price;
  final int amount;
  final String requirements;
  final double upkeep;

  Product2({
    required this.name,
    required this.price,
    required this.amount,
    required this.requirements,
    required this.upkeep,
  });

  factory Product2.fromJson(Map<String, dynamic> json) => Product2(
        name: json['name'] ?? '',
        price: json['price']?.toDouble() ?? 0.0,
        amount: json['amount'] ?? 0,
        requirements: json['requirements'] ?? '',
        upkeep: json['upkeep']?.toDouble() ?? '',
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'amount': amount,
        'requirements': requirements,
        'upkeep': upkeep,
      };

  bool isValid() =>
      name.isNotEmpty &&
      price > 0 &&
      amount > 0 &&
      requirements.isNotEmpty &&
      upkeep > 0;
}
