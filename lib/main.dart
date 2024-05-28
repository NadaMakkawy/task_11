import 'package:flutter/material.dart';
// import 'package:flut_grouped_buttons/flut_grouped_buttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 11',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Android ATC Hotel'),
    );
  }
}

class HomePage extends StatefulWidget {
  final String? title;
  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Map<String, bool>> allItemsList = [
  //   {'Item 1': false},
  //   {'Item 2': false},
  //   {'Item 3': false},
  //   {'Item 4': false},
  //   {'Item 5': false},
  //   {'Item 6': false},
  // ];

  List<Map<String, dynamic>> allItemsList = [
    {
      'title': 'Item 1 title',
      'description': 'item 1 description',
      'number': 1,
      'isSelected': false
    },
    {
      'title': 'Item 2 title',
      'description': 'item 2 description',
      'number': 2,
      'isSelected': false
    },
    {
      'title': 'Item 3 title',
      'description': 'item 3 description',
      'number': 3,
      'isSelected': false
    },
    {
      'title': 'Item 4 title',
      'description': 'item 4 description',
      'number': 4,
      'isSelected': false
    },
    {
      'title': 'Item 5 title',
      'description': 'item 5 description',
      'number': 5,
      'isSelected': false
    },
    {
      'title': 'Item 6 title',
      'description': 'item 6 description',
      'number': 6,
      'isSelected': false
    },
  ];

  List<Map<String, dynamic>> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems.addAll(allItemsList);
  }

  void updateFilteredList() {
    filteredItems = allItemsList.where((item) => item['isSelected']).toList();
    if (filteredItems.isEmpty) {
      filteredItems.addAll(allItemsList);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Column(
        children: <Widget>[
          Text('Select items:'),
          Expanded(
            child: ListView.builder(
              itemCount: allItemsList.length,
              itemBuilder: (context, index) {
                String itemName = allItemsList[index]['title'];
                String itemDescription = allItemsList[index]['description'];
                int itemNumber = allItemsList[index]['number'];
                bool isSelected = allItemsList[index]['isSelected'];
                return CheckListOption(
                  isSelected: isSelected,
                  itemName: itemName,
                  itemText: '''
Item description: $itemDescription
Item count: $itemNumber
''',
                  onChangedFn: (value) {
                    setState(
                      () {
                        allItemsList[index]['isSelected'] = value!;
                        updateFilteredList();
                      },
                    );
                  },
                );
              },
            ),
          ),
          Divider(),
          Text('Filtered List:'),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                String itemName = filteredItems[index]['title'];
                return ListTile(
                  title: Text(itemName),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CheckListOption extends StatefulWidget {
  final String itemName;
  final String itemText;
  final bool isSelected;
  final Function(bool?)? onChangedFn;

  const CheckListOption({
    super.key,
    required this.itemName,
    required this.itemText,
    required this.isSelected,
    required this.onChangedFn,
  });

  @override
  State<CheckListOption> createState() => _CheckListOptionState();
}

class _CheckListOptionState extends State<CheckListOption> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.itemName),
      subtitle: Text(widget.itemText),
      value: widget.isSelected,
      onChanged: widget.onChangedFn,
    );
  }
}
