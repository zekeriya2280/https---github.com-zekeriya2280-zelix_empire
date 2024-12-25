import 'package:flutter/material.dart';
import 'package:zelix_empire/models/city.dart';
import 'package:zelix_empire/models/truck.dart';
import 'package:zelix_empire/models/warehouse.dart';
import 'package:zelix_empire/pages/citydetailspage.dart';

class CitiesPage extends StatefulWidget {
  const CitiesPage({super.key});
 
@override _CitiesPageState createState()=>_CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {
  
final List<City> cities=[
City(name:"City A",price : 1000,level: 1,productDemands: {},warehouse :Warehouse(cityName: "City A",level: 1,storedProducts: {},waitUntilFullPerProduct: {}),),
City(name:"City B",price : 2000,level: 2,productDemands: {"A": 10, "B": 20},warehouse :Warehouse(cityName: "City B",level: 2,storedProducts: {},waitUntilFullPerProduct: {}),),
City(name:"City C",price : 3000,level: 3,productDemands: {"C": 30, "D": 40},warehouse :Warehouse(cityName: "City C",level: 3,storedProducts: {},waitUntilFullPerProduct: {}),),
];

final List<Truck> trucks=[
Truck(id :1,capacity :50, sourceCity: "City A", destinationCity: "City B"),
Truck(id :2,capacity :100, sourceCity: "City B", destinationCity: "City C"),
];

@override Widget build(BuildContext context){
return Scaffold(
appBar: AppBar(title: Text("Cities")),
body: ListView.builder(
itemCount: cities.length,
itemBuilder: (context, index) { 
final City currentcity = cities[index];
return Card(
  child: ListTile(
    title: Text(currentcity.name),
    subtitle:
    Text(currentcity.isPurchased() ? "Purchased" : "Price: \$${currentcity.price}"),
    trailing: currentcity.isPurchased()
    ? Icon(Icons.check, color: Colors.green)
    : ElevatedButton(
      onPressed: () { 
        setState(() { 
          currentcity.setPurchased();
        });
      },
      child: Text("Buy"),
    ),
    onTap: () { 
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:(context)=>CityDetailsPage(
            city:currentcity,trucks:trucks)),
      );
    },
  ),
);
},
),
);
}
}