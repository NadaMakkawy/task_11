import 'package:flutter/material.dart';

import '../data/extras_data.dart';

class ExtrasChecklistWidget extends StatefulWidget {
  final List<Map<String, dynamic>> selectedItemsPrice;
  final double totalPrice;

  ExtrasChecklistWidget({
    super.key,
    required this.selectedItemsPrice,
    required this.totalPrice,
  });

  @override
  State<ExtrasChecklistWidget> createState() => _ExtrasChecklistWidgetState();
}

class _ExtrasChecklistWidgetState extends State<ExtrasChecklistWidget> {
  @override
  Widget build(BuildContext context) {
    // final totalPrice = getTotalPrice();

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: extrasData.length,
            itemBuilder: (context, index) {
              final item = extrasData[index];
              return CheckboxListTile(
                title: Text(item['title']),
                value: item['isSelected'],
                onChanged: (value) {
                  setState(() {
                    item['isSelected'] = value!;
                    if (value) {
                      widget.selectedItemsPrice.add(item);
                    } else {
                      widget.selectedItemsPrice.remove(item);
                    }
                  });
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Total Price: \$${widget.totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
