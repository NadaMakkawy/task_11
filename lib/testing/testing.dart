import 'package:flutter/material.dart';
import 'package:task_11/data/extras_data.dart';
import 'package:task_11/data/rooms_data.dart';

class ChecklistItem {
  final String name;
  final double price;
  bool isSelected;

  ChecklistItem(this.name, this.price, {this.isSelected = false});
}

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  _ChecklistScreenState createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  List<Map<String, dynamic>> selectedItems = [];
  Map<String, dynamic>? selectedRadioItem;

  double getTotalPrice() {
    double totalPrice = 0;
    for (var item in selectedItems) {
      totalPrice += item['price'];
    }
    return totalPrice;
  }

  void navigateToSummaryScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryScreen(selectedItems: selectedItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = getTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checklists'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
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
                        selectedItems.add(item);
                      } else {
                        selectedItems.remove(item);
                      }
                    });
                  },
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: roomsData.length,
              itemBuilder: (context, index) {
                final item = roomsData[index];
                return RadioListTile<Map<String, dynamic>>(
                  title: Text(item['title']),
                  value: item,
                  onChanged: (value) {
                    setState(() {
                      selectedRadioItem = value;
                      selectedItems.clear();
                      if (value != null) {
                        selectedItems.add({
                          'title': value['title'],
                          'price': value['price'],
                        });
                      }
                    });
                  },
                  groupValue: selectedRadioItem,
                );
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
          ElevatedButton(
            onPressed: navigateToSummaryScreen,
            child: const Text('Go to Summary'),
          ),
        ],
      ),
    );
  }
}

class SummaryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> selectedItems;

  const SummaryScreen({super.key, required this.selectedItems});

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
