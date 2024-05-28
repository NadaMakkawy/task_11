import 'package:flutter/material.dart';
import 'package:task_11/room_list_view_widget.dart';
import 'package:task_11/view_check_widget.dart';

import 'extras_checklist_widget.dart';
import 'slide_bar_widget.dart';
import 'date_picker_widget.dart';

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

  const HomePage({super.key, this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(
          widget.title!,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Image.asset('assets/entrance.jpg'),
              ),
              const DatePickerWidget(),
              const SlideBarWidget(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: ExtrasChecklistWidget(),
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 1,
              //   child: RoomListView(),
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1,
                child: ViewCheckWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
