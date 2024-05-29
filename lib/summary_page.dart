import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  final List<Map<String, dynamic>> selectedItems;

  const SummaryPage({super.key, required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    for (var item in selectedItems) {
      totalPrice += item['price'];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: selectedItems.length,
              itemBuilder: (context, index) {
                final item = selectedItems[index];
                return ListTile(
                  title: Text(item['title']),
                  subtitle: Text('Price: \$${item['price']}'),
                );
                //     ListTile(
                //   leading: Image.asset(item['imagePath']),
                //   title: Text(
                //     item['title'],
                //     style: const TextStyle(
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   subtitle: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(item['description']),
                //       Row(
                //         children: [
                //           const Icon(Icons.person),
                //           Text(item['capacity']),
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           const Icon(Icons.park),
                //           Text(item['view']),
                //         ],
                //       ),
                //     ],
                //   ),
                // );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total Price: \$${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
