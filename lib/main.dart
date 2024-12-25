import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zelix_empire/models/allmodels.dart';

void main() {
  City initialCity = City(
    name: "Default City A",
    price: 100,
    isThisCityPurchased: false,
    level: 1,
    productDemands: {},
    warehouse: Warehouse(
      cityName: "Default A",
      level: 1,
      storedProducts: {},
      waitUntilFullPerProduct: {},
    ), 
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<City>(
          create: (_) => initialCity,
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rise of Industry Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late City _city;
  late Truck _truck;

  @override
  void initState() {
    super.initState();
    
    try {
      _city = Provider.of<City>(context, listen: false);
      dispatchTrucks(_city);
      _city.tryUpgrade();
      _truck = Truck(
        id: 1,
        sourceCity: _city.name,
        destinationCity: "City B",
        capacity: 100,
      );
      print('Initialized city and truck');
    } catch (e) {
      print('Error initializing city and truck: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        appBar: AppBar(
          title: Text('Rise of Industry Game'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('City: ${_city.name}'),
              Text('Level: ${_city.level}'),
              Text('Product Demands: ${_city.productDemands}'),
              Text('Warehouse: ${_city.warehouse.storedProducts}'),
              SizedBox(height: 20),
              Text('Truck: ${_truck.id}'),
              Text('Source City: ${_truck.sourceCity}'),
              Text('Destination City: ${_truck.destinationCity}'),
            ],
          ),
        ),
      );
    } catch (e) {
      print('Error building widget: $e');
      return Text('Error building widget');
    }
  }
}