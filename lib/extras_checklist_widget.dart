import 'package:flutter/material.dart';

class ExtrasChecklistWidget extends StatefulWidget {
  const ExtrasChecklistWidget({super.key});

  @override
  State<ExtrasChecklistWidget> createState() => _ExtrasChecklistWidgetState();
}

class _ExtrasChecklistWidgetState extends State<ExtrasChecklistWidget> {
  List<Map<String, dynamic>> extrasList = [
    {
      'title': 'Breakfast',
      'price': 10.0,
      'isSelected': false,
    },
    {
      'title': 'Internet WiFi',
      'price': 5.0,
      'isSelected': false,
    },
    {
      'title': 'Parking',
      'price': 5.0,
      'isSelected': false,
    },
    {
      'title': 'Swimming Pool',
      'price': 10.0,
      'isSelected': false,
    },
  ];

  List<Map<String, dynamic>> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems.addAll(extrasList);
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var item in filteredItems) {
      if (item['isSelected']) {
        totalPrice += item['price'];
      }
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: extrasList.length,
          itemBuilder: (context, index) {
            final item = extrasList[index];
            return CheckboxListTile(
              title: Text(
                '${extrasList[index]['title']} - ${extrasList[index]['price']} EGP',
              ),
              value: item['isSelected'],
              onChanged: (bool? value) {
                item['isSelected'] = value;
                setState(() {});
              },
            );
          },
        ),
        Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text(
            'Total Price: ${calculateTotalPrice()} EGP',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
