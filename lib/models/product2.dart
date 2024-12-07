import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Product2 {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final double price;
  @HiveField(2)
  final int amount;
  @HiveField(3)
  final String requirements;
  @HiveField(4)
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
