/// Represents a warehouse with levels and capacity for storing products.
class Warehouse {
  final String cityName; // Name of the city the warehouse belongs to
  int level; // Warehouse level (1, 2, or 3)
  Map<String, int> storedProducts = {}; // Products and their stored quantities
  Map<String, bool> waitUntilFullPerProduct = {}; // Wait Until Full setting per product

  Warehouse({
    required this.cityName,
    this.level = 1,
    required Map<String, int>? storedProducts,
    required Map<String, bool>? waitUntilFullPerProduct,
  });

  /// Gets the maximum capacity for any product based on the warehouse level.
  int get maxCapacityPerProduct {
    switch (level) {
      case 1:
        return 74;
      case 2:
        return 84;
      case 3:
        return 99;
      default:
        return 74;
    }
  }

  /// Checks if the warehouse is full for a specific product.
  bool isFull(String product) =>
      (storedProducts[product] ?? 0) >= maxCapacityPerProduct;

  /// Adds products to the warehouse, respecting capacity limits.
  int addProduct(String product, int quantity) {
    int currentQuantity = storedProducts[product] ?? 0;
    int availableSpace = maxCapacityPerProduct - currentQuantity;

    int addedQuantity = quantity.clamp(0, availableSpace);
    storedProducts[product] = currentQuantity + addedQuantity;

    return addedQuantity; // Return how much was actually added
  }

  /// Removes products from the warehouse for truck loading.
  int removeProduct(String product, int quantity) {
    int currentQuantity = storedProducts[product] ?? 0;
    int removedQuantity = quantity.clamp(0, currentQuantity);

    storedProducts[product] = currentQuantity - removedQuantity;

    return removedQuantity; // Return how much was actually removed
  }

  /// Checks if "Wait Until Full" is enabled for a specific product.
  bool isWaitUntilFullEnabled(String product) =>
      waitUntilFullPerProduct[product] ?? false;

  /// Sets "Wait Until Full" for a specific product.
  void setWaitUntilFull(String product, bool enabled) {
    waitUntilFullPerProduct[product] = enabled;
  }

  factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
        cityName: json['cityName'],
        level: json['level'],
        storedProducts: json['storedProducts'] != null
            ? Map<String, int>.from(json['storedProducts'])
            : {},
        waitUntilFullPerProduct: json['waitUntilFullPerProduct'] != null
            ? Map<String, bool>.from(json['waitUntilFullPerProduct'])
            : {},
      );
}

/// Represents a city with warehouses and upkeep costs for trucks.
class City {
  final String name; // Name of the city
  int level; // City level
  Map<String, int> productDemands; // Products and their demanded quantities
  Warehouse warehouse; // City's warehouse

  City({
    required this.name,
    required this.level,
    required this.productDemands,
    required this.warehouse,
  });

  /// Checks if all product demands are fulfilled.
  bool areDemandsMet() => productDemands.values.every((quantity) => quantity <= 0);

  /// Calculates upkeep cost for a truck journey based on city level.
  double calculateUpkeepCost(int truckCapacity) {
    return truckCapacity * level * 1.5; // Example formula: capacity * level * factor
  }

  /// Tries to upgrade the city when all demands are met.
  void tryUpgrade() {
    if (areDemandsMet() && level < 5) {
      level++; // Increase city level
      print("City $name upgraded to level $level.");
    }
  }
  factory City.fromJson(Map<String, dynamic> json) => City(
        name: json['name'],
        level: json['level'],
        productDemands: Map<String, int>.from(json['productDemands']),
        warehouse: Warehouse.fromJson(json['warehouse']),
      );
}

/// Represents a truck for transporting products between cities.
class Truck {
  final int id; // Unique identifier for the truck
  final int capacity; // Maximum carrying capacity
  Map<String, int> currentLoad; // Map of loaded products and quantities
  String sourceCity; // Starting city
  String destinationCity; // Delivery city

  Truck({
    required this.id,
    required this.capacity,
    required this.sourceCity,
    required this.destinationCity,
  }) : currentLoad = {};

  /// Gets the total load currently in the truck.
  int get totalLoad => currentLoad.values.fold(0, (sum, qty) => sum + qty);

  /// Checks if the truck can carry more products.
  bool canLoadMore(int quantity) => totalLoad + quantity <= capacity;

  /// Loads a specific product into the truck.
  bool loadProduct(String product, int quantity) {
    if (canLoadMore(quantity)) {
      currentLoad[product] = (currentLoad[product] ?? 0) + quantity;
      return true;
    }
    return false; // Not enough space
  }

  /// Starts the journey and calculates upkeep cost.
 void startJourney(double upkeepCost) {
   print(
       "Truck $id started journey from $sourceCity to $destinationCity. Upkeep cost: \$${upkeepCost.toStringAsFixed(2)}");
   completeMission();
 }

 /// Completes the journey and resets load.
 void completeMission() {
   currentLoad.clear();
   print("Truck $id completed its journey and is now empty.");
 }
}

/// Dispatches trucks from a city's warehouse based on "Wait Until Full" setting per product.
void dispatchTrucks(City city) {
 Warehouse warehouse=city.warehouse;
 int truckIdCounter=1;

 while (!city.areDemandsMet()) {
   Truck truck=Truck(
     id:truckIdCounter++,
     capacity:warehouse.maxCapacityPerProduct,
     sourceCity:city.name,
     destinationCity:"Destination City",
   );

   bool loadedAnyProduct=false;

   for (var entry in city.productDemands.entries.toList()) {
     String product=entry.key;
     int demand=entry.value;

     if (demand<=0 || !warehouse.storedProducts.containsKey(product)) continue;

     bool waitForFull=warehouse.isWaitUntilFullEnabled(product);
     if (waitForFull && warehouse.storedProducts[product]!<truck.capacity) continue;

     int loadQuantity=
         demand.clamp(0,truck.capacity-truck.totalLoad).clamp(0,warehouse.storedProducts[product] as int ?? 0);

     if (loadQuantity>0 && truck.loadProduct(product,loadQuantity)) {
       city.productDemands[product] = (city.productDemands[product] as int) - loadQuantity;
       warehouse.removeProduct(product,loadQuantity);
       loadedAnyProduct=true;
       print("Truck ${truck.id} loaded $loadQuantity of $product from ${city.name}.");
     }
   }

   if (loadedAnyProduct) {
     double upkeepCost=city.calculateUpkeepCost(truck.capacity);
     truck.startJourney(upkeepCost);
   } else {
     break;
   }
 }
}
