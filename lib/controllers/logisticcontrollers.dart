import 'package:zelix_empire/models/city.dart';
import 'package:zelix_empire/models/truck.dart';
import 'package:zelix_empire/models/warehouse.dart';

class LogisticControllers{ 
  void dispatchTrucks(City city) {
  Warehouse warehouse = city.warehouse;
  int truckIdCounter = 1;

  while (!city.areDemandsMet()) {
    Truck truck = Truck(
      id: truckIdCounter++,
      capacity: warehouse.maxCapacityPerProduct,
      sourceCity: city.name,
      destinationCity: "Destination City",
    );

    bool loadedAnyProduct = false;

    for (var entry in city.productDemands.entries.toList()) {
      String product = entry.key;
      int? demand = entry.value;

      if (demand <= 0 || !warehouse.storedProducts.containsKey(product)) {
        continue;
      }

      bool waitForFull = warehouse.isWaitUntilFullEnabled(product);
      if (waitForFull && (warehouse.storedProducts[product] ?? 0) < truck.capacity) {
        continue;
      }

      int loadQuantity = demand
          .clamp(0, truck.capacity - truck.totalLoad)
          .clamp(0, warehouse.storedProducts[product] ?? 0);

      if (loadQuantity > 0 && truck.loadProduct(product, loadQuantity)) {
        city.productDemands[product] =
            (city.productDemands[product] ?? 0) - loadQuantity;
        warehouse.removeProduct(product, loadQuantity);
        loadedAnyProduct = true;
        print(
            "Truck ${truck.id} loaded $loadQuantity of $product from ${city.name}.");
      }
    }

    if (loadedAnyProduct) {
      double upkeepCost = city.calculateUpkeepCost(truck.capacity);
      truck.startJourney(upkeepCost);
    } else {
      break;
    }
  }
}
}