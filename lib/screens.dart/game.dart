import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zelix_empire/firebase/fbcontroller.dart';
import 'package:zelix_empire/models/product.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Timer? _timer;
  int usermoney = 0;
  bool canbebought = false;
  String selecteditem = 'Water';
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    findusermoney();
    super.initState();
  }

  Future<void> findusermoney() async {
    await Fbcontroller().findUserMoney().then((value) {
      setState(() {
        usermoney = value;
      });
    });
  }
  void startCountdown(Map<String, dynamic> material) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async{
      await fetchProductionTime(material['name']);
    });
  }

  Future<void> fetchProductionTime(String materialname) async {
  String currentid = '1';
  int productionTime = 0;
  QuerySnapshot<Map<String, dynamic>> documentSnapshot =
      await FirebaseFirestore.instance.collection('products').get();
  for (var doc in documentSnapshot.docs) {
    if (doc.data()['name'] == materialname) {
      currentid = doc.id;
      productionTime = int.tryParse(doc.data()['duration'].toString()) ?? 0;
      break;
    }
  }
  if (productionTime >= 0) {
    productionTime -= 1;
    final batch = FirebaseFirestore.instance.batch();
    batch.update(FirebaseFirestore.instance.collection('products').doc(currentid), {'duration': productionTime.toString()});
    await batch.commit();
  }
}
  Future<void> updateSelectedItem(String item) async {
  setState(() {
    selecteditem = item;
  });

  try {
    final canBeProduced = await Fbcontroller().canBeProducedByCheckingRequiredMaterials(selecteditem);

    setState(() {
      canbebought = canBeProduced;
    });
  } catch (e) {
    print('Error checking if product can be produced: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  backgroundColor: Color.fromARGB(255, 0, 191, 255), // beautiful blue color
  elevation: 0,
  leading: null, // remove back button
  title: Row(
    children: [
      Text(
        '\$${usermoney.toString()}',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ],
  ),
),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const SizedBox(); // or return a loading indicator
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching materials'));
          }

          // Eğer veri başarılı bir şekilde gelmişse, bir GridView'da gösteriyoruz.
          final List<Map<String, dynamic>> materials = snapshot.data!.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // İki sütunlu grid
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
              //childAspectRatio: 0.8,
              mainAxisExtent: 300,
            ),
            itemCount: materials.length,
            itemBuilder: (context, index) {
              materials.sort((a, b) => a['level'].compareTo(b['level']));
              Product material = Product.fromMap(materials[index]);
              
              return Card(
                color: !canbebought ? Colors.redAccent : const Color.fromARGB(255, 255, 255, 255),
                elevation: 5,
                child: InkWell(
                  onTap: () async
                    {
                    await updateSelectedItem(material.name);
                    canbebought ? startCountdown(material.toMap()) : true;
                  },
                  child: SizedBox(
                    height: 4000,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(material.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Color.fromARGB(230, 255, 111, 0))),
                          const SizedBox(height: 10),
                          Text('Level: \$${material.level.toString()}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromARGB(230, 13, 89, 240))),
                          Text(
                            'Purchase Price: \$${material.basePurchasePrice.toString()}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color.fromARGB(255, 100, 89,
                                    25) // new color: golden yellow
                                ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Sale Price: \$${material.baseSalePrice.toString()}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color.fromARGB(
                                    255, 34, 139, 34) // new color: forest green
                                ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Duration: ${material.duration.toString()}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color.fromARGB(
                                    255, 128, 0, 128) // new color: purple
                                ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Demand Index: ${material.demandindex.toString()}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color.fromARGB(
                                    255, 0, 191, 255) // new color: sky blue
                                ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Required Materials: \n ${
                              material.requiredMaterials!.isEmpty ? 'None' :
                              material.requiredMaterials.toString().substring(2,material.requiredMaterials.toString().length-2).split('}').join(' ').split('{').join(' ')}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color.fromARGB(
                                    255, 165, 42, 42) // new color: brown
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
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
