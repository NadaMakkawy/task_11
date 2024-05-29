import 'package:flutter/material.dart';

import 'rooms_data.dart';

class SlideBarWidget extends StatefulWidget {
  const SlideBarWidget({super.key});

  @override
  State<SlideBarWidget> createState() => _SlideBarWidgetState();
}

class _SlideBarWidgetState extends State<SlideBarWidget> {
  void filterRoomsData() {
    List<Map<String, dynamic>> filteredRoomsbyCap = roomsData.where((room) {
      int capacity = room['capacity'] as int;
      return capacity >= adultSliderValue && capacity >= chilrenSliderValue;
    }).toList();
  }

  double adultSliderValue = 1;
  double chilrenSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SlideBarTemp(
            currentSliderValue: adultSliderValue,
            title: 'Adults',
            minVal: 1,
            divisions: 4,
            filterRoomsData: filterRoomsData,
          ),
          SlideBarTemp(
            currentSliderValue: chilrenSliderValue,
            title: 'Children',
            minVal: 0,
            divisions: 5,
            filterRoomsData: filterRoomsData,
          ),
        ],
      ),
    );
  }
}

class SlideBarTemp extends StatefulWidget {
  double currentSliderValue;
  final String title;
  final double minVal;
  final int divisions;
  final Function filterRoomsData;

  SlideBarTemp(
      {super.key,
      required this.currentSliderValue,
      required this.title,
      required this.minVal,
      required this.divisions,
      required this.filterRoomsData});

  @override
  State<SlideBarTemp> createState() => _SlideBarTempState();
}

class _SlideBarTempState extends State<SlideBarTemp> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: FittedBox(
            child: Text(
              '${widget.title}: ${widget.currentSliderValue.round()}',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 280,
          child: Slider(
            value: widget.currentSliderValue,
            min: widget.minVal,
            max: 5,
            divisions: widget.divisions,
            activeColor: Colors.blue,
            label: widget.currentSliderValue.round().toString(),
            onChanged: (double value) {
              widget.currentSliderValue = value;
              widget.filterRoomsData;

              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
