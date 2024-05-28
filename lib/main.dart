import 'package:flutter/material.dart';
import 'package:flut_grouped_buttons/flut_grouped_buttons.dart';

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
  List<Map<String, String>> _checkedItems = [
    {"id": 'id1', "name": "item 1"},
    {"id": 'id2', "name": "item 2"},
    {"id": 'id3', "name": "item 3"},
    {"id": 'id4', "name": "item 4"},
    {"id": 'id5', "name": "item 5"},
    {"id": 'id6', "name": "item 6"},
    {"id": 'id7', "name": "item 7"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Select Items:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FlutGroupedButtons<Map<String, String>>(
                idKey: 'id',
                valueKey: 'name',
                data: _checkedItems,
                onChanged: (id) => print(id),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
