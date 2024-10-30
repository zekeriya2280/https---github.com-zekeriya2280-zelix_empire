import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zelix_empire/models/product.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    
    super.initState();
  }

Function? startCountdown(Map<String, dynamic> material) {
   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    fetchProductionTime(material['name']);
  });
  return null;
}

void fetchProductionTime(String materialname) async {
  String currentid = '1';
  int productionTime = 0;
  QuerySnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance.collection('products').get();
    for (var doc in documentSnapshot.docs) {
      if(doc.data()['name'] == materialname){
         currentid = doc.id;
         productionTime = int.parse(doc.data()['duration'].toString());
      } 
    }
  productionTime >= 0 ? productionTime -= 1 : true;
  productionTime >= 0 ? await FirebaseFirestore.instance.collection('products').doc(currentid).update({'duration': productionTime.toString()}) : true;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game')),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching materials'));
          }

          // Eğer veri başarılı bir şekilde gelmişse, bir GridView'da gösteriyoruz.
          final List<Map<String, dynamic>> materials = snapshot.data!.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // İki sütunlu grid
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3 / 2,
            ),
            itemCount: materials.length,
            itemBuilder: (context, index) {
              Product material = Product.fromMap(materials[index]);
              return Card(
  elevation: 5,
  child: InkWell(
    onTap: () {
      startCountdown(material.toMap());
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            material.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Text('Level: \$${material.level.toString()}'),
          Text('Base Purchase Price: \$${material.basePurchasePrice.toString()}'),
          Text('Base Sale Price: \$${material.baseSalePrice.toString()}'),
          Text('Duration: ${material.duration.toString()}'),
          Text('Inflation: ${material.demandindex.toString()}'),
          Text('Required Materials: ${material.requiredMaterials.toString()}'),
        ],
      ),
    ),
  ),
);
            },
          );
        },
      ),
    );
  }
}
