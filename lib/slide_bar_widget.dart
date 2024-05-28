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
    return Scaffold(
      appBar: AppBar(
        title: Text('Slide Bar'),
      ),
      body: Center(
        child: SlideSelectionBar(),
      ),
    );
  }
}

class SlideSelectionBar extends StatefulWidget {
  const SlideSelectionBar({super.key});

  @override
  State<SlideSelectionBar> createState() => _SlideSelectionBarState();
}

class _SlideSelectionBarState extends State<SlideSelectionBar> {
  double currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
        SizedBox(height: 20),
        Text(
          'Selected Number of People: ${currentSliderValue.round()}',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
