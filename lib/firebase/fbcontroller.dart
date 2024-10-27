import 'package:cloud_firestore/cloud_firestore.dart';

class Fbcontroller {
  Future<void> addProductsToFirestore() async {
    // Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Ürünlerin JSON formatında listesi
    List<Map<String, dynamic>> products = [
      {
    "name": "Iron Ore",
    "level": 1,
    "basePurchasePrice": 100,
    "salePurchasePrice": 105,
    "duration": 300,
    "requiredMaterials": [],
    "inflation": 0
  },
  {
    "name": "Copper Ore",
    "level": 1,
    "basePurchasePrice": 120,
    "salePurchasePrice": 126,
    "duration": 320,
    "requiredMaterials": [],
    "inflation": 0
  },
  {
    "name": "Coal",
    "level": 1,
    "basePurchasePrice": 60,
    "salePurchasePrice": 63,
    "duration": 250,
    "requiredMaterials": [],
    "inflation": 0
  },
  {
    "name": "Limestone",
    "level": 1,
    "basePurchasePrice": 70,
    "salePurchasePrice": 73.5,
    "duration": 260,
    "requiredMaterials": [],
    "inflation": 0
  },
  {
    "name": "Sand",
    "level": 1,
    "basePurchasePrice": 80,
    "salePurchasePrice": 84,
    "duration": 200,
    "requiredMaterials": [],
    "inflation": 0
  },
  {
    "name": "Water",
    "level": 1,
    "basePurchasePrice": 10,
    "salePurchasePrice": 10.5,
    "duration": 100,
    "requiredMaterials": [],
    "inflation": 0
  },
  {
    "name": "Clay",
    "level": 1,
    "basePurchasePrice": 65,
    "salePurchasePrice": 68.25,
    "duration": 220,
    "requiredMaterials": [],
    "inflation": 0
  },
  {
    "name": "Sulfur",
    "level": 1,
    "basePurchasePrice": 75,
    "salePurchasePrice": 78.75,
    "duration": 240,
    "requiredMaterials": [],
    "inflation": 0
  },
  {
    "name": "Nickel",
    "level": 1,
    "basePurchasePrice": 90,
    "salePurchasePrice": 94.5,
    "duration": 270,
    "requiredMaterials": [],
    "inflation": 0
  },
  {
    "name": "Zinc",
    "level": 1,
    "basePurchasePrice": 85,
    "salePurchasePrice": 89.25,
    "duration": 280,
    "requiredMaterials": [],
    "inflation": 0
  },
  {
    "name": "Graphite",
    "level": 1,
    "basePurchasePrice": 95,
    "salePurchasePrice": 99.75,
    "duration": 290,
    "requiredMaterials": [],
    "inflation": 0
  },
  {
    "name": "Gypsum",
    "level": 1,
    "basePurchasePrice": 55,
    "salePurchasePrice": 57.75,
    "duration": 230,
    "requiredMaterials": [],
    "inflation": 0
  },
  {
    "name": "Salt",
    "level": 1,
    "basePurchasePrice": 40,
    "salePurchasePrice": 42,
    "duration": 210,
    "requiredMaterials": [],
    "inflation": 0
  },
  {
    "name": "Bauxite",
    "level": 1,
    "basePurchasePrice": 110,
    "salePurchasePrice": 115.5,
    "duration": 330,
    "requiredMaterials": [],
    "inflation": 0
  },
  {
    "name": "Lithium Ore",
    "level": 1,
    "basePurchasePrice": 130,
    "salePurchasePrice": 136.5,
    "duration": 340,
    "requiredMaterials": [],
    "inflation": 0
  },
  {
    "name": "Magnesium",
    "level": 1,
    "basePurchasePrice": 95,
    "salePurchasePrice": 99.75,
    "duration": 310,
    "requiredMaterials": [],
    "inflation": 0
  },
  {
    "name": "Potassium",
    "level": 1,
    "basePurchasePrice": 85,
    "salePurchasePrice": 89.25,
    "duration": 300,
    "requiredMaterials": [],
    "inflation": 0
  },
  {
    "name": "Phosphorus",
    "level": 1,
    "basePurchasePrice": 70,
    "salePurchasePrice": 73.5,
    "duration": 280,
    "requiredMaterials": [],
    "inflation": 0
  },
  {
    "name": "Uranium",
    "level": 1,
    "basePurchasePrice": 500,
    "salePurchasePrice": 525,
    "duration": 400,
    "requiredMaterials": [],
    "inflation": 0
  },
  {
    "name": "Thorium",
    "level": 1,
    "basePurchasePrice": 600,
    "salePurchasePrice": 630,
    "duration": 450,
    "requiredMaterials": [],
    "inflation": 0
  },
      {
    "name": "Wheat",
    "level": 2,
    "basePurchasePrice": 90,
    "salePurchasePrice": 95,
    "duration": 300,
    "requiredMaterials": ["Water"],
    "inflation": 0
  },
  {
    "name": "Corn",
    "level": 2,
    "basePurchasePrice": 85,
    "salePurchasePrice": 89,
    "duration": 320,
    "requiredMaterials": ["Water"],
    "inflation": 0
  },
  {
    "name": "Cotton",
    "level": 2,
    "basePurchasePrice": 75,
    "salePurchasePrice": 78.75,
    "duration": 280,
    "requiredMaterials": ["Water"],
    "inflation": 0
  },
  {
    "name": "Sugarcane",
    "level": 2,
    "basePurchasePrice": 70,
    "salePurchasePrice": 73.5,
    "duration": 260,
    "requiredMaterials": ["Water"],
    "inflation": 0
  },
  {
    "name": "Tobacco",
    "level": 2,
    "basePurchasePrice": 95,
    "salePurchasePrice": 99.75,
    "duration": 300,
    "requiredMaterials": ["Water"],
    "inflation": 0
  },
      {
    "name": "Rice",
    "level": 2,
    "basePurchasePrice": 90,
    "salePurchasePrice": 95,
    "duration": 340,
    "requiredMaterials": ["Water"],
    "inflation": 0
  },
  {
    "name": "Barley",
    "level": 2,
    "basePurchasePrice": 80,
    "salePurchasePrice": 84,
    "duration": 330,
    "requiredMaterials": ["Water"],
    "inflation": 0
  },
  {
    "name": "Soybeans",
    "level": 2,
    "basePurchasePrice": 78,
    "salePurchasePrice": 81.9,
    "duration": 320,
    "requiredMaterials": ["Water"],
    "inflation": 0
  },
  {
    "name": "Vegetables",
    "level": 2,
    "basePurchasePrice": 95,
    "salePurchasePrice": 99.75,
    "duration": 350,
    "requiredMaterials": ["Water"],
    "inflation": 0
  },
  {
    "name": "Fruits",
    "level": 2,
    "basePurchasePrice": 100,
    "salePurchasePrice": 105,
    "duration": 360,
    "requiredMaterials": ["Water"],
    "inflation": 0
  },
  {
    "name": "Olives",
    "level": 2,
    "basePurchasePrice": 110,
    "salePurchasePrice": 115.5,
    "duration": 330,
    "requiredMaterials": ["Water"],
    "inflation": 0
  },
  {
    "name": "Hops",
    "level": 2,
    "basePurchasePrice": 88,
    "salePurchasePrice": 92.4,
    "duration": 280,
    "requiredMaterials": ["Water"],
    "inflation": 0
  },
  {
    "name": "Coffee Beans",
    "level": 2,
    "basePurchasePrice": 120,
    "salePurchasePrice": 126,
    "duration": 390,
    "requiredMaterials": ["Water"],
    "inflation": 0
  },
  {
    "name": "Rubber",
    "level": 2,
    "basePurchasePrice": 130,
    "salePurchasePrice": 136.5,
    "duration": 400,
    "requiredMaterials": ["Water"],
    "inflation": 0
  },
  {
    "name": "Fish",
    "level": 2,
    "basePurchasePrice": 140,
    "salePurchasePrice": 147,
    "duration": 410,
    "requiredMaterials": ["Water"],
    "inflation": 0
  },
  {
    "name": "Timber",
    "level": 2,
    "basePurchasePrice": 150,
    "salePurchasePrice": 157.5,
    "duration": 430,
    "requiredMaterials": ["Water"],
    "inflation": 0
  },
  {
    "name": "Wool",
    "level": 2,
    "basePurchasePrice": 95,
    "salePurchasePrice": 99.75,
    "duration": 280,
    "requiredMaterials": ["Water"],
    "inflation": 0
  },
  {
    "name": "Milk",
    "level": 2,
    "basePurchasePrice": 85,
    "salePurchasePrice": 89.25,
    "duration": 260,
    "requiredMaterials": ["Water"],
    "inflation": 0
  },
  {
    "name": "Leather",
    "level": 2,
    "basePurchasePrice": 70,
    "salePurchasePrice": 73.5,
    "duration": 310,
    "requiredMaterials": ["Water"],
    "inflation": 0
  },
  {
    "name": "Honey",
    "level": 2,
    "basePurchasePrice": 105,
    "salePurchasePrice": 110.25,
    "duration": 300,
    "requiredMaterials": ["Water"],
    "inflation": 0
  },
  {
    "name": "Eggs",
    "level": 2,
    "basePurchasePrice": 50,
    "salePurchasePrice": 52.5,
    "duration": 240,
    "requiredMaterials": ["Water"],
    "inflation": 0
  },
  {
    "name": "Cheese",
    "level": 2,
    "basePurchasePrice": 120,
    "salePurchasePrice": 126,
    "duration": 320,
    "requiredMaterials": ["Milk"],
    "inflation": 0
  },
  {
    "name": "Butter",
    "level": 2,
    "basePurchasePrice": 115,
    "salePurchasePrice": 120.75,
    "duration": 280,
    "requiredMaterials": ["Milk"],
    "inflation": 0
  },
      {
    "name": "Wheat Flour",
    "level": 3,
    "basePurchasePrice": 130,
    "salePurchasePrice": 136.5,
    "duration": 400,
    "requiredMaterials": ["Wheat"],
    "inflation": 0
  },
  {
    "name": "Bread",
    "level": 3,
    "basePurchasePrice": 140,
    "salePurchasePrice": 147,
    "duration": 420,
    "requiredMaterials": ["Wheat Flour", "Water"],
    "inflation": 0
  },
  {
    "name": "Beef",
    "level": 3,
    "basePurchasePrice": 150,
    "salePurchasePrice": 157.5,
    "duration": 440,
    "requiredMaterials": ["Cattle"],
    "inflation": 0
  },
  {
    "name": "Pork",
    "level": 3,
    "basePurchasePrice": 145,
    "salePurchasePrice": 152.25,
    "duration": 450,
    "requiredMaterials": ["Pig"],
    "inflation": 0
  },
  {
    "name": "Chicken Meat",
    "level": 3,
    "basePurchasePrice": 135,
    "salePurchasePrice": 141.75,
    "duration": 430,
    "requiredMaterials": ["Chicken"],
    "inflation": 0
  },
  {
    "name": "Steel",
    "level": 3,
    "basePurchasePrice": 160,
    "salePurchasePrice": 168,
    "duration": 450,
    "requiredMaterials": ["Iron Ore", "Coal"],
    "inflation": 0
  },
  {
    "name": "Copper Wire",
    "level": 3,
    "basePurchasePrice": 170,
    "salePurchasePrice": 178.5,
    "duration": 460,
    "requiredMaterials": ["Copper Ore"],
    "inflation": 0
  },
  {
    "name": "Glass",
    "level": 3,
    "basePurchasePrice": 130,
    "salePurchasePrice": 136.5,
    "duration": 440,
    "requiredMaterials": ["Sand"],
    "inflation": 0
  },
      {
    "name": "Concrete",
    "level": 3,
    "basePurchasePrice": 125,
    "salePurchasePrice": 131.25,
    "duration": 440,
    "requiredMaterials": ["Sand", "Limestone"],
    "inflation": 0
  },
  {
    "name": "Cloth",
    "level": 3,
    "basePurchasePrice": 115,
    "salePurchasePrice": 120.75,
    "duration": 400,
    "requiredMaterials": ["Cotton"],
    "inflation": 0
  },
  {
    "name": "Paper",
    "level": 3,
    "basePurchasePrice": 110,
    "salePurchasePrice": 115.5,
    "duration": 420,
    "requiredMaterials": ["Timber"],
    "inflation": 0
  },
  {
    "name": "Leather Shoes",
    "level": 3,
    "basePurchasePrice": 160,
    "salePurchasePrice": 168,
    "duration": 430,
    "requiredMaterials": ["Leather"],
    "inflation": 0
  },
  {
    "name": "Wooden Furniture",
    "level": 3,
    "basePurchasePrice": 180,
    "salePurchasePrice": 189,
    "duration": 470,
    "requiredMaterials": ["Timber"],
    "inflation": 0
  },
  {
    "name": "Brick",
    "level": 3,
    "basePurchasePrice": 140,
    "salePurchasePrice": 147,
    "duration": 410,
    "requiredMaterials": ["Clay"],
    "inflation": 0
  },
  {
    "name": "Sugar",
    "level": 3,
    "basePurchasePrice": 125,
    "salePurchasePrice": 131.25,
    "duration": 420,
    "requiredMaterials": ["Sugarcane"],
    "inflation": 0
  },
  {
    "name": "Jam",
    "level": 3,
    "basePurchasePrice": 145,
    "salePurchasePrice": 152.25,
    "duration": 410,
    "requiredMaterials": ["Fruits", "Sugar"],
    "inflation": 0
  },
  {
    "name": "Canned Fish",
    "level": 3,
    "basePurchasePrice": 155,
    "salePurchasePrice": 162.75,
    "duration": 440,
    "requiredMaterials": ["Fish", "Tin"],
    "inflation": 0
  },
  {
    "name": "Juice",
    "level": 3,
    "basePurchasePrice": 130,
    "salePurchasePrice": 136.5,
    "duration": 400,
    "requiredMaterials": ["Fruits", "Water"],
    "inflation": 0
  },
  {
    "name": "Yogurt",
    "level": 3,
    "basePurchasePrice": 135,
    "salePurchasePrice": 141.75,
    "duration": 390,
    "requiredMaterials": ["Milk"],
    "inflation": 0
  },
  {
    "name": "Plastic",
    "level": 3,
    "basePurchasePrice": 165,
    "salePurchasePrice": 173.25,
    "duration": 450,
    "requiredMaterials": ["Oil"],
    "inflation": 0
  },
  {
    "name": "Battery",
    "level": 3,
    "basePurchasePrice": 190,
    "salePurchasePrice": 199.5,
    "duration": 480,
    "requiredMaterials": ["Copper", "Lithium"],
    "inflation": 0
  },
  {
    "name": "Processed Wood",
    "level": 3,
    "basePurchasePrice": 105,
    "salePurchasePrice": 110.25,
    "duration": 390,
    "requiredMaterials": ["Timber"],
    "inflation": 0
  },
  {
    "name": "Pet Food",
    "level": 3,
    "basePurchasePrice": 120,
    "salePurchasePrice": 126,
    "duration": 370,
    "requiredMaterials": ["Meat", "Grains"],
    "inflation": 0
  },
  {
    "name": "Petrol",
    "level": 3,
    "basePurchasePrice": 155,
    "salePurchasePrice": 162.75,
    "duration": 460,
    "requiredMaterials": ["Oil"],
    "inflation": 0
  },
      {
    "name": "Engine",
    "level": 4,
    "basePurchasePrice": 220,
    "salePurchasePrice": 231,
    "duration": 520,
    "requiredMaterials": ["Steel", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Laptop",
    "level": 4,
    "basePurchasePrice": 300,
    "salePurchasePrice": 315,
    "duration": 680,
    "requiredMaterials": ["Plastic", "Battery", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Smartphone",
    "level": 4,
    "basePurchasePrice": 290,
    "salePurchasePrice": 304.5,
    "duration": 650,
    "requiredMaterials": ["Plastic", "Battery", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Car",
    "level": 4,
    "basePurchasePrice": 400,
    "salePurchasePrice": 420,
    "duration": 700,
    "requiredMaterials": ["Engine", "Steel", "Plastic"],
    "inflation": 0
  },
     {
    "name": "TV",
    "level": 4,
    "basePurchasePrice": 280,
    "salePurchasePrice": 294,
    "duration": 660,
    "requiredMaterials": ["Plastic", "Glass", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Refrigerator",
    "level": 4,
    "basePurchasePrice": 320,
    "salePurchasePrice": 336,
    "duration": 700,
    "requiredMaterials": ["Plastic", "Steel", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Washing Machine",
    "level": 4,
    "basePurchasePrice": 330,
    "salePurchasePrice": 346.5,
    "duration": 710,
    "requiredMaterials": ["Plastic", "Steel", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Drone",
    "level": 4,
    "basePurchasePrice": 350,
    "salePurchasePrice": 367.5,
    "duration": 720,
    "requiredMaterials": ["Plastic", "Battery", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Medical Equipment",
    "level": 4,
    "basePurchasePrice": 390,
    "salePurchasePrice": 409.5,
    "duration": 760,
    "requiredMaterials": ["Plastic", "Steel", "Battery"],
    "inflation": 0
  },
  {
    "name": "Tablet",
    "level": 4,
    "basePurchasePrice": 295,
    "salePurchasePrice": 309.75,
    "duration": 640,
    "requiredMaterials": ["Plastic", "Battery", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Air Conditioner",
    "level": 4,
    "basePurchasePrice": 340,
    "salePurchasePrice": 357,
    "duration": 730,
    "requiredMaterials": ["Plastic", "Steel", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Electric Scooter",
    "level": 4,
    "basePurchasePrice": 310,
    "salePurchasePrice": 325.5,
    "duration": 690,
    "requiredMaterials": ["Plastic", "Battery", "Steel"],
    "inflation": 0
  },
  {
    "name": "Electric Bike",
    "level": 4,
    "basePurchasePrice": 370,
    "salePurchasePrice": 388.5,
    "duration": 720,
    "requiredMaterials": ["Plastic", "Battery", "Steel"],
    "inflation": 0
  },
  {
    "name": "Robot",
    "level": 4,
    "basePurchasePrice": 500,
    "salePurchasePrice": 525,
    "duration": 800,
    "requiredMaterials": ["Battery", "Copper Wire", "Plastic"],
    "inflation": 0
  },
  {
    "name": "Microwave",
    "level": 4,
    "basePurchasePrice": 310,
    "salePurchasePrice": 325.5,
    "duration": 700,
    "requiredMaterials": ["Plastic", "Steel", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Gaming Console",
    "level": 4,
    "basePurchasePrice": 330,
    "salePurchasePrice": 346.5,
    "duration": 710,
    "requiredMaterials": ["Plastic", "Battery", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Vacuum Cleaner",
    "level": 4,
    "basePurchasePrice": 260,
    "salePurchasePrice": 273,
    "duration": 630,
    "requiredMaterials": ["Plastic", "Battery", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Electric Oven",
    "level": 4,
    "basePurchasePrice": 325,
    "salePurchasePrice": 341.25,
    "duration": 710,
    "requiredMaterials": ["Plastic", "Steel", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Industrial Robot Arm",
    "level": 4,
    "basePurchasePrice": 550,
    "salePurchasePrice": 577.5,
    "duration": 820,
    "requiredMaterials": ["Steel", "Battery", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "3D Printer",
    "level": 4,
    "basePurchasePrice": 380,
    "salePurchasePrice": 399,
    "duration": 750,
    "requiredMaterials": ["Plastic", "Steel", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Smart Home Hub",
    "level": 4,
    "basePurchasePrice": 260,
    "salePurchasePrice": 273,
    "duration": 610,
    "requiredMaterials": ["Plastic", "Battery", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Solar Panel",
    "level": 4,
    "basePurchasePrice": 450,
    "salePurchasePrice": 472.5,
    "duration": 780,
    "requiredMaterials": ["Plastic", "Glass", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Wind Turbine",
    "level": 4,
    "basePurchasePrice": 620,
    "salePurchasePrice": 651,
    "duration": 850,
    "requiredMaterials": ["Steel", "Copper Wire", "Plastic"],
    "inflation": 0
  },
  {
    "name": "Electric Car",
    "level": 4,
    "basePurchasePrice": 750,
    "salePurchasePrice": 787.5,
    "duration": 900,
    "requiredMaterials": ["Battery", "Steel", "Copper Wire", "Plastic"],
    "inflation": 0
  },
        {
    "name": "Space Satellite",
    "level": 5,
    "basePurchasePrice": 1200,
    "salePurchasePrice": 1260,
    "duration": 1200,
    "requiredMaterials": ["Steel", "Battery", "Solar Panel", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Space Habitat Module",
    "level": 5,
    "basePurchasePrice": 1800,
    "salePurchasePrice": 1890,
    "duration": 1400,
    "requiredMaterials": ["Steel", "Plastic", "Battery", "Glass"],
    "inflation": 0
  },
  {
    "name": "Space Rover",
    "level": 5,
    "basePurchasePrice": 1500,
    "salePurchasePrice": 1575,
    "duration": 1300,
    "requiredMaterials": ["Steel", "Battery", "Solar Panel", "Glass"],
    "inflation": 0
  },
  {
    "name": "Mars Oxygen Generator",
    "level": 5,
    "basePurchasePrice": 1600,
    "salePurchasePrice": 1680,
    "duration": 1350,
    "requiredMaterials": ["Steel", "Battery", "Plastic", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Space Suit",
    "level": 5,
    "basePurchasePrice": 1100,
    "salePurchasePrice": 1155,
    "duration": 1250,
    "requiredMaterials": ["Plastic", "Glass", "Battery", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Rocket Engine",
    "level": 5,
    "basePurchasePrice": 2500,
    "salePurchasePrice": 2625,
    "duration": 1500,
    "requiredMaterials": ["Steel", "Battery", "Copper Wire", "Fuel"],
    "inflation": 0
  },
  {
    "name": "Space Telescope",
    "level": 5,
    "basePurchasePrice": 2000,
    "salePurchasePrice": 2100,
    "duration": 1400,
    "requiredMaterials": ["Glass", "Steel", "Battery", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Solar Sail",
    "level": 5,
    "basePurchasePrice": 1300,
    "salePurchasePrice": 1365,
    "duration": 1200,
    "requiredMaterials": ["Plastic", "Solar Panel", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Cryogenic Fuel Tank",
    "level": 5,
    "basePurchasePrice": 2200,
    "salePurchasePrice": 2310,
    "duration": 1450,
    "requiredMaterials": ["Steel", "Plastic", "Copper Wire", "Fuel"],
    "inflation": 0
  },
  {
    "name": "Space Dock",
    "level": 5,
    "basePurchasePrice": 2800,
    "salePurchasePrice": 2940,
    "duration": 1550,
    "requiredMaterials": ["Steel", "Battery", "Solar Panel", "Glass"],
    "inflation": 0
  },
  {
    "name": "Planetary Drill",
    "level": 5,
    "basePurchasePrice": 2100,
    "salePurchasePrice": 2205,
    "duration": 1350,
    "requiredMaterials": ["Steel", "Battery", "Copper Wire", "Drill Bit"],
    "inflation": 0
  },
  {
    "name": "Radiation Shield",
    "level": 5,
    "basePurchasePrice": 1700,
    "salePurchasePrice": 1785,
    "duration": 1300,
    "requiredMaterials": ["Plastic", "Steel", "Glass", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Ion Thruster",
    "level": 5,
    "basePurchasePrice": 2300,
    "salePurchasePrice": 2415,
    "duration": 1450,
    "requiredMaterials": ["Steel", "Battery", "Copper Wire", "Xenon Fuel"],
    "inflation": 0
  },
  {
    "name": "Artificial Gravity Generator",
    "level": 5,
    "basePurchasePrice": 3000,
    "salePurchasePrice": 3150,
    "duration": 1600,
    "requiredMaterials": ["Steel", "Battery", "Copper Wire", "Magnet"],
    "inflation": 0
  },
  {
    "name": "Extraterrestrial Farm Module",
    "level": 5,
    "basePurchasePrice": 1900,
    "salePurchasePrice": 1995,
    "duration": 1350,
    "requiredMaterials": ["Plastic", "Steel", "Battery", "Water"],
    "inflation": 0
  },
  {
    "name": "Asteroid Mining Drill",
    "level": 5,
    "basePurchasePrice": 2500,
    "salePurchasePrice": 2625,
    "duration": 1500,
    "requiredMaterials": ["Steel", "Battery", "Drill Bit", "Copper Wire"],
    "inflation": 0
  },
  {
    "name": "Space Beacon",
    "level": 5,
    "basePurchasePrice": 1600,
    "salePurchasePrice": 1680,
    "duration": 1200,
    "requiredMaterials": ["Steel", "Battery", "Copper Wire", "Plastic"],
    "inflation": 0
  },
  {
    "name": "Mars Transportation Pod",
    "level": 5,
    "basePurchasePrice": 2700,
    "salePurchasePrice": 2835,
    "duration": 1550,
    "requiredMaterials": ["Steel", "Battery", "Plastic", "Glass"],
    "inflation": 0
  },
  {
    "name": "Interstellar Communication Array",
    "level": 5,
    "basePurchasePrice": 2400,
    "salePurchasePrice": 2520,
    "duration": 1500,
    "requiredMaterials": ["Steel", "Battery", "Copper Wire", "Glass"],
    "inflation": 0
  },
  {
    "name": "Fusion Reactor Core",
    "level": 5,
    "basePurchasePrice": 5000,
    "salePurchasePrice": 5250,
    "duration": 1800,
    "requiredMaterials": ["Steel", "Battery", "Magnet", "Cooling System"],
    "inflation": 0
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
