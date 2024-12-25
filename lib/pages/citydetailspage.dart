import 'package:flutter/material.dart';
import 'package:zelix_empire/models/allmodels.dart';

class CityDetailsPage extends StatefulWidget {
  final City city;
  final List<Truck> trucks;

  const CityDetailsPage({
    super.key,
    required this.city,
    required this.trucks,
  });

  @override
  _CityDetailsPageState createState() => _CityDetailsPageState();
}

class _CityDetailsPageState extends State<CityDetailsPage> {
  void unlockProductDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Unlock Product"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List.generate(5, (index) {
                String product = "Product ${index + 1}";
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.city.unlockProduct(product);
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text(product),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.city.name} Details")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: unlockProductDialog,
            child: Text("Unlock Product"),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: widget.trucks.length,
                itemBuilder: (context, index) {
                  final truck = widget.trucks[index];
                  return Card(
                    child: ListTile(
                      title: Text("Truck ${truck.id}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...truck.currentLoad.entries.map(
                            (entry) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${entry.key}: ${entry.value}"),
                                  Switch(
                                      value: widget.city.warehouse
                                          .isWaitUntilFullEnabled(entry.key),
                                      onChanged: (value) {
                                        setState(() {
                                          widget.city.warehouse.setWaitUntilFull(
                                              entry.key, value);
                                        });
                                      }),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
