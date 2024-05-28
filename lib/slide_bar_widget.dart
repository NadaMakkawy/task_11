import 'package:flutter/material.dart';

class SlideBarWidget extends StatefulWidget {
  const SlideBarWidget({Key? key});

  @override
  State<SlideBarWidget> createState() => _SlideBarWidgetState();
}

class _SlideBarWidgetState extends State<SlideBarWidget> {
  double currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: FittedBox(
            child: Text(
              'Selected Number of People: ${currentSliderValue.round()}',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        SizedBox(height: 20),
        Slider(
          value: currentSliderValue,
          min: 0,
          max: 5,
          divisions: 5,
          label: currentSliderValue.round().toString(),
          onChanged: (double value) {
            currentSliderValue = value;
            setState(() {});
          },
        ),
      ],
    );
  }
}
