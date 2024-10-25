import 'package:cloud_firestore/cloud_firestore.dart';

class Fbcontroller {
  Future<void> addProductsToFirestore() async {
  // Firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Ürünlerin JSON formatında listesi
  List<Map<String, dynamic>> products = [
  {
    "name": "Iron Ore",
    "price": 100,
    "production_time": 300,
    "level": 1
  },
  {
    "name": "Copper Ore",
    "price": 120,
    "production_time": 320,
    "level": 1
  },
  {
    "name": "Sand",
    "price": 80,
    "production_time": 200,
    "level": 1
  },
  {
    "name": "Limestone",
    "price": 90,
    "production_time": 250,
    "level": 1
  },
  {
    "name": "Coal",
    "price": 110,
    "production_time": 350,
    "level": 1
  },
  {
    "name": "Clay",
    "price": 70,
    "production_time": 220,
    "level": 1
  },
  {
    "name": "Wood",
    "price": 50,
    "production_time": 180,
    "level": 1
  },
  {
    "name": "Stone",
    "price": 60,
    "production_time": 240,
    "level": 1
  },
  {
    "name": "Gravel",
    "price": 55,
    "production_time": 190,
    "level": 1
  },
  {
    "name": "Water",
    "price": 40,
    "production_time": 160,
    "level": 1
  },
  {
    "name": "Salt",
    "price": 75,
    "production_time": 230,
    "level": 1
  },
  {
    "name": "Sulfur",
    "price": 130,
    "production_time": 400,
    "level": 1
  },
  {
    "name": "Quartz",
    "price": 140,
    "production_time": 420,
    "level": 1
  },
  {
    "name": "Bauxite",
    "price": 150,
    "production_time": 430,
    "level": 1
  },
  {
    "name": "Oil",
    "price": 200,
    "production_time": 500,
    "level": 1
  },
  {
    "name": "Natural Gas",
    "price": 180,
    "production_time": 480,
    "level": 1
  },
  {
    "name": "Gold Ore",
    "price": 300,
    "production_time": 600,
    "level": 1
  },
  {
    "name": "Silver Ore",
    "price": 250,
    "production_time": 550,
    "level": 1
  },
  {
    "name": "Tin Ore",
    "price": 110,
    "production_time": 340,
    "level": 1
  },
  {
    "name": "Uranium Ore",
    "price": 400,
    "production_time": 700,
    "level": 1
  },

  {
    "name": "Wheat",
    "price": 90,
    "production_time": 300,
    "level": 2
  },
  {
    "name": "Corn",
    "price": 85,
    "production_time": 320,
    "level": 2
  },
  {
    "name": "Rice",
    "price": 80,
    "production_time": 310,
    "level": 2
  },
  {
    "name": "Barley",
    "price": 75,
    "production_time": 280,
    "level": 2
  },
  {
    "name": "Potatoes",
    "price": 70,
    "production_time": 270,
    "level": 2
  },
  {
    "name": "Tomatoes",
    "price": 65,
    "production_time": 260,
    "level": 2
  },
  {
    "name": "Apples",
    "price": 120,
    "production_time": 340,
    "level": 2
  },
  {
    "name": "Oranges",
    "price": 110,
    "production_time": 330,
    "level": 2
  },
  {
    "name": "Bananas",
    "price": 130,
    "production_time": 350,
    "level": 2
  },
  {
    "name": "Grapes",
    "price": 140,
    "production_time": 360,
    "level": 2
  },
  {
    "name": "Cotton",
    "price": 60,
    "production_time": 240,
    "level": 2
  },
  {
    "name": "Soybeans",
    "price": 55,
    "production_time": 230,
    "level": 2
  },
  {
    "name": "Sugar Cane",
    "price": 50,
    "production_time": 220,
    "level": 2
  },
  {
    "name": "Coffee Beans",
    "price": 150,
    "production_time": 380,
    "level": 2
  },
  {
    "name": "Cocoa Beans",
    "price": 160,
    "production_time": 390,
    "level": 2
  },
  {
    "name": "Peanuts",
    "price": 70,
    "production_time": 250,
    "level": 2
  },
  {
    "name": "Sunflower Seeds",
    "price": 75,
    "production_time": 260,
    "level": 2
  },
  {
    "name": "Oats",
    "price": 65,
    "production_time": 240,
    "level": 2
  },
  {
    "name": "Lettuce",
    "price": 45,
    "production_time": 200,
    "level": 2
  },
  {
    "name": "Carrots",
    "price": 50,
    "production_time": 210,
    "level": 2
  },

  {
    "name": "Steel",
    "price": 500,
    "production_time": 600,
    "level": 3
  },
  {
    "name": "Glass",
    "price": 400,
    "production_time": 550,
    "level": 3
  },
  {
    "name": "Plastic",
    "price": 450,
    "production_time": 580,
    "level": 3
  },
  {
    "name": "Concrete",
    "price": 350,
    "production_time": 520,
    "level": 3
  },
  {
    "name": "Paper",
    "price": 300,
    "production_time": 480,
    "level": 3
  },
  {
    "name": "Aluminum",
    "price": 550,
    "production_time": 650,
    "level": 3
  },
  {
    "name": "Rubber",
    "price": 420,
    "production_time": 500,
    "level": 3
  },
  {
    "name": "Textile",
    "price": 320,
    "production_time": 490,
    "level": 3
  },
  {
    "name": "Cement",
    "price": 360,
    "production_time": 530,
    "level": 3
  },
  {
    "name": "Fertilizer",
    "price": 380,
    "production_time": 540,
    "level": 3
  },
  {
    "name": "Paint",
    "price": 410,
    "production_time": 560,
    "level": 3
  },
  {
    "name": "Copper Wire",
    "price": 460,
    "production_time": 590,
    "level": 3
  },
  {
    "name": "Circuit Board",
    "price": 470,
    "production_time": 600,
    "level": 3
  },
  {
    "name": "Batteries",
    "price": 480,
    "production_time": 620,
    "level": 3
  },
  {
    "name": "Canned Food",
    "price": 320,
    "production_time": 480,
    "level": 3
  },
  {
    "name": "Flour",
    "price": 330,
    "production_time": 490,
    "level": 3
  },
  {
    "name": "Vegetable Oil",
    "price": 340,
    "production_time": 500,
    "level": 3
  },
  {
    "name": "Leather",
    "price": 350,
    "production_time": 510,
    "level": 3
  },
    {
    "name": "Synthetic Fiber",
    "price": 450,
    "production_time": 580,
    "level": 3
  },
  {
    "name": "Medicine",
    "price": 600,
    "production_time": 700,
    "level": 3
  },
  {
    "name": "Petroleum",
    "price": 550,
    "production_time": 650,
    "level": 3
  },
  {
    "name": "Fabrics",
    "price": 300,
    "production_time": 500,
    "level": 3
  },

  {
    "name": "Space Shuttle",
    "price": 15000,
    "production_time": 2000,
    "level": 4
  },
  {
    "name": "Satellite",
    "price": 12000,
    "production_time": 1800,
    "level": 4
  },
  {
    "name": "Solar Panels",
    "price": 8000,
    "production_time": 1600,
    "level": 4
  },
  {
    "name": "Advanced Batteries",
    "price": 6000,
    "production_time": 1400,
    "level": 4
  },
  {
    "name": "Quantum Processor",
    "price": 9000,
    "production_time": 1700,
    "level": 4
  },
  {
    "name": "Fusion Reactor",
    "price": 20000,
    "production_time": 2200,
    "level": 4
  },
  {
    "name": "Exoskeleton Suit",
    "price": 11000,
    "production_time": 1900,
    "level": 4
  },
  {
    "name": "Laser Weapons",
    "price": 13000,
    "production_time": 2100,
    "level": 4
  },
  {
    "name": "Advanced Robotics",
    "price": 14000,
    "production_time": 1950,
    "level": 4
  },
  {
    "name": "Hypersonic Jet",
    "price": 17000,
    "production_time": 2150,
    "level": 4
  },
  {
    "name": "Biotech Implant",
    "price": 16000,
    "production_time": 2050,
    "level": 4
  },
  {
    "name": "Space Habitat",
    "price": 25000,
    "production_time": 2500,
    "level": 4
  },
  {
    "name": "Nanotechnology",
    "price": 18000,
    "production_time": 2300,
    "level": 4
  },
  {
    "name": "AI Core",
    "price": 19000,
    "production_time": 2400,
    "level": 4
  },
  {
    "name": "Plasma Shield",
    "price": 13500,
    "production_time": 2000,
    "level": 4
  },
  {
    "name": "Zero-Gravity Furnace",
    "price": 14500,
    "production_time": 2100,
    "level": 4
  },
  {
    "name": "Dark Matter Containment",
    "price": 22000,
    "production_time": 2700,
    "level": 4
  },
  {
    "name": "Wormhole Generator",
    "price": 30000,
    "production_time": 3000,
    "level": 4
  },
  {
    "name": "Antimatter Engine",
    "price": 28000,
    "production_time": 2900,
    "level": 4
  },

  {
    "name": "Hyperdrive",
    "price": 35000,
    "production_time": 3200,
    "level": 5
  },
  {
    "name": "Terraforming Equipment",
    "price": 40000,
    "production_time": 3500,
    "level": 5
  },
  {
    "name": "Cryogenic Chamber",
    "price": 32000,
    "production_time": 3100,
    "level": 5
  },
  {
    "name": "Self-Healing Materials",
    "price": 33000,
    "production_time": 3300,
    "level": 5
  },
  {
    "name": "Antigravity Device",
    "price": 45000,
    "production_time": 3700,
    "level": 5
  },
  {
    "name": "Teleportation Pad",
    "price": 50000,
    "production_time": 4000,
    "level": 5
  },
  {
    "name": "Gravity Manipulator",
    "price": 42000,
    "production_time": 3600,
    "level": 5
  },
  {
    "name": "Neural Interface",
    "price": 39000,
    "production_time": 3400,
    "level": 5
  },
  {
    "name": "Energy Shield",
    "price": 38000,
    "production_time": 3300,
    "level": 5
  },
  {
    "name": "Bioengineered Organs",
    "price": 35000,
    "production_time": 3250,
    "level": 5
  },
  {
    "name": "Quantum Communication Device",
    "price": 48000,
    "production_time": 3900,
    "level": 5
  },
  {
    "name": "Singularity Reactor",
    "price": 55000,
    "production_time": 4500,
    "level": 5
  },
  {
    "name": "Stellar Forge",
    "price": 60000,
    "production_time": 4700,
    "level": 5
  },
  {
    "name": "Nano Assembler",
    "price": 52000,
    "production_time": 4300,
    "level": 5
  },
  {
    "name": "Quantum Battery",
    "price": 46000,
    "production_time": 4000,
    "level": 5
  },
  {
    "name": "Matter Replicator",
    "price": 57000,
    "production_time": 4400,
    "level": 5
  },
  {
    "name": "Universal Translator",
    "price": 51000,
    "production_time": 4200,
    "level": 5
  },
  {
    "name": "Time Dilation Device",
    "price": 53000,
    "production_time": 4500,
    "level": 5
  },
  {
    "name": "Dimensional Rift Generator",
    "price": 60000,
    "production_time": 4700,
    "level": 5
  },
  {
    "name": "Stellar Drive",
    "price": 65000,
    "production_time": 5000,
    "level": 5
  }
];


  // Firestore batch işlemi
  WriteBatch batch = firestore.batch();

  // Her bir ürünü "products" koleksiyonuna ekliyoruz
  for (Map<String, dynamic> product in products) {
    DocumentReference docRef = firestore.collection('products').doc();
    batch.set(docRef, product);
  }

  // Batch işlemini Firestore'a gönderiyoruz
  try {
    await batch.commit();
    print('Ürünler başarıyla Firestore\'a eklendi.');
  } catch (e) {
    print('Ürünler eklenirken hata oluştu: $e');
  }
}
}
