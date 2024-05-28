import 'package:flutter/material.dart';

class DatePickerPage extends StatefulWidget {
  const DatePickerPage({super.key});

  @override
  State<DatePickerPage> createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  DateTime? startDate;
  DateTime? endDate;

  int getSelectedDays() {
    if (startDate != null && endDate != null) {
      final difference = endDate!.difference(startDate!);
      return difference.inDays + 1;
    }
    return 0;
  }

  String getSelectedDateRange() {
    if (startDate != null && endDate != null) {
      return '${startDate!.toString().split(' ')[0]}  to  ${endDate!.toString().split(' ')[0]}';
    }
    return 'Not Selected';
  }

  Future<void> selectDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: startDate ?? DateTime.now(),
      end: endDate ?? DateTime.now().add(Duration(days: 3)),
    );

    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 120)),
      initialDateRange: initialDateRange,
    );

    if (picked != null) {
      startDate = picked.start;
      endDate = picked.end;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Check-in Date: ${startDate != null ? startDate!.toString().split(' ')[0] : 'Not Selected'}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 40),
            Text(
              'Check-Out Date: ${endDate != null ? endDate!.toString().split(' ')[0] : 'Not Selected'}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => selectDateRange(context),
              child: Text('Select Date Range'),
            ),
            SizedBox(height: 20),
            Text(
              'Selected Date Range:\n${getSelectedDateRange()}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Selected Days: ${getSelectedDays()}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
