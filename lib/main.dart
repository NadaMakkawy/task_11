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
      'title': 'Master Room Sea View',
      'description': 'King Bed Room with beautiful sea view',
      'capacity': '1 : 2',
      'isSelected': false
    },
    {
      'title': 'Master Room City View',
      'description': 'King Bed Room with luxurious city view',
      'capacity': '1 : 2',
      'isSelected': false
    },
    {
      'title': 'Twin Room Sea View',
      'description': 'Two beds Room for two people with beautiful sea view',
      'capacity': '2',
      'isSelected': false
    },
    {
      'title': 'Twin Room City View',
      'description': 'Two beds Room for two people with luxurious city view',
      'capacity': '2',
      'isSelected': false
    },
    {
      'title': 'Triple Room Sea View',
      'description':
          'Three beds Room for three or more people with beautiful sea view',
      'capacity': '1 : 3',
      'isSelected': false
    },
    {
      'title': 'Triple Room City View',
      'description':
          'Three beds Room for three or more people with luxurious city view',
      'capacity': '1 : 3',
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
            child: CheckListOptionsList(
              itemsList: allItemsList,
              updateFilteredListFn: updateFilteredList,
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
  final Column itemText;
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
      subtitle: widget.itemText,
      value: widget.isSelected,
      onChanged: widget.onChangedFn,
    );
  }
}

class CheckListOptionsList extends StatefulWidget {
  final List<Map<String, dynamic>> itemsList;
  final Function updateFilteredListFn;

  const CheckListOptionsList({
    super.key,
    required this.itemsList,
    required this.updateFilteredListFn,
  });

  @override
  State<CheckListOptionsList> createState() => _CheckListOptionsListState();
}

class _CheckListOptionsListState extends State<CheckListOptionsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.itemsList.length,
      itemBuilder: (context, index) {
        String itemName = widget.itemsList[index]['title'];
        String itemDescription = widget.itemsList[index]['description'];
        String itemcapacity = widget.itemsList[index]['capacity'];
        bool isSelected = widget.itemsList[index]['isSelected'];
        return CheckListOption(
          isSelected: isSelected,
          itemName: itemName,
          itemText: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$itemDescription'),
              Row(
                children: [
                  Icon(
                    Icons.person,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('$itemcapacity')
                ],
              )
            ],
          ),
          onChangedFn: (value) {
            setState(
              () {
                widget.itemsList[index]['isSelected'] = value!;
                widget.updateFilteredListFn();
              },
            );
          },
        );
      },
    );
  }
}
