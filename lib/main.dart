import 'package:flutter/material.dart';

import 'date_range_picker.dart';
import 'slide_bar_widget.dart';

// import 'first_attempt.dart';

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
      // home: const HomePage(title: 'Android ATC Hotel'),
      home: SlideBarWidget(),
    );
  }
}
