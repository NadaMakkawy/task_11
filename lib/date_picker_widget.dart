import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? startDate;
  DateTime? endDate;

  int getSelectedDays() {
    if (startDate != null && endDate != null) {
      final difference = endDate!.difference(startDate!);
      return difference.inDays + 1;
    }
    return 0;
  }

  // String getSelectedDateRange() {
  //   if (startDate != null && endDate != null) {
  //     return '${startDate!.toString().split(' ')[0]}  to  ${endDate!.toString().split(' ')[0]}';
  //   }
  //   return 'Not Selected';
  // }

  Future<void> selectDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: startDate ?? DateTime.now(),
      end: endDate ?? DateTime.now().add(const Duration(days: 3)),
    );

    final picked = await showDateRangePicker(
      // initialEntryMode: DatePickerEntryMode.input,
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 120)),
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
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              const Text(
                'Check-in Date : ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              Text(
                startDate != null
                    ? startDate!.toString().split(' ')[0]
                    : 'Not Selected',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text(
                'Check-Out Date : ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              Text(
                endDate != null
                    ? endDate!.toString().split(' ')[0]
                    : 'Not Selected',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  elevation: 3,
                ),
                onPressed: () => selectDateRange(context),
                child: const Text(
                  'Select Date Range',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    children: [
                      // Text(
                      //   '${getSelectedDateRange()}',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     color: Colors.blue,
                      //   ),
                      // ),
                      Text(
                        'Selected Days: ${getSelectedDays()}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
