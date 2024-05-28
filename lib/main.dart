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
      debugShowCheckedModeBanner: false,
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
      'isSelected': false,
      'imagePath': 'assets/master-sea.jpg',
      'view': 'Sea View'
    },
    {
      'title': 'Master Room City View',
      'description': 'King Bed Room with luxurious city view',
      'capacity': '1 : 2',
      'isSelected': false,
      'imagePath': 'assets/master-city.jpg',
      'view': 'City View'
    },
    {
      'title': 'Twin Room Sea View',
      'description': 'Two beds Room for two people with beautiful sea view',
      'capacity': '2',
      'isSelected': false,
      'imagePath': 'assets/twin-sea.jpg',
      'view': 'Sea View'
    },
    {
      'title': 'Twin Room City View',
      'description': 'Two beds Room for two people with luxurious city view',
      'capacity': '2',
      'isSelected': false,
      'imagePath': 'assets/twin-city.jpg',
      'view': 'City View'
    },
    {
      'title': 'Triple Room Sea View',
      'description':
          'Three beds Room for three or more people with beautiful sea view',
      'capacity': '1 : 3',
      'isSelected': false,
      'imagePath': 'assets/three-bed-sea.jpg',
      'view': 'Sea View'
    },
    {
      'title': 'Triple Room City View',
      'description':
          'Three beds Room for three or more people with luxurious city view',
      'capacity': '1 : 3',
      'isSelected': false,
      'imagePath': 'assets/three-bed-city.jpg',
      'view': 'City View'
    },
  ];

  List<Map<String, dynamic>> filteredItems = [];
  List<Map<String, dynamic>> viewFilteredItems = [];

  String viewFilter = '';

  @override
  void initState() {
    super.initState();
    viewFilteredItems.addAll(allItemsList);
  }

  // void updateViewFilteredList() {
  //   viewFilteredItems = allItemsList
  //       .where((item) => item['view'] == viewFilter || viewFilter.isEmpty)
  //       .toList();

  //   setState(() {});
  // }

  void updateFilteredList() {
    filteredItems = allItemsList.where((item) => item['isSelected']).toList();

    viewFilteredItems = allItemsList
        .where((item) => item['view'] == viewFilter || viewFilter.isEmpty)
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body:
          // first simple checklist
          //  Column(
          //   children: <Widget>[
          //     Text('Select items:'),
          //     Expanded(
          //       child: CheckListOptionsList(
          //         itemsList: allItemsList,
          //         updateFilteredListFn: updateFilteredList,
          //       ),
          //     ),
          //     Divider(),
          //     Text('Filtered List:'),
          //     Expanded(
          //       child: ListView.builder(
          //         itemCount: filteredItems.length,
          //         itemBuilder: (context, index) {
          //           String itemName = filteredItems[index]['title'];
          //           return ListTile(
          //             title: Text(itemName),
          //           );
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          //     );
          //   }
          // }

          // checklist based on filters
          Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  viewFilter = 'Sea View';
                  updateFilteredList();
                  setState(() {});
                },
                child: Text('Sea View'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  viewFilter = 'City View';
                  updateFilteredList();
                  setState(() {});
                },
                child: Text('City View'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  viewFilter = '';
                  updateFilteredList();
                  setState(() {});
                },
                child: Text('Clear Filter'),
              ),
            ],
          ),
          Expanded(
            child: CheckListOptionsList(
              itemsList: viewFilteredItems,
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
  final String? imagePath;
  final Column itemText;
  final bool isSelected;
  final Function(bool?)? onChangedFn;

  const CheckListOption({
    super.key,
    required this.itemName,
    this.imagePath,
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
      title: ListTile(
        leading: Container(
          child: Image.asset(widget.imagePath!),
        ),
        // CircleAvatar(
        //   backgroundImage: AssetImage(widget.imagePath!),
        //   radius: 30,
        // ),
        contentPadding: EdgeInsets.all(0),
        title: Text(widget.itemName),
        subtitle: widget.itemText,
      ),
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
        String imagePath = widget.itemsList[index]['imagePath'];

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
          imagePath: imagePath,
        );
      },
    );
  }
}
