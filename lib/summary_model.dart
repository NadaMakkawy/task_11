import 'package:flutter/material.dart';

class SummaryModel {
  final String selectedRoom;
  final int total;
  final Widget checkout;

  SummaryModel(
    this.selectedRoom,
    this.total,
    this.checkout,
  );
}
