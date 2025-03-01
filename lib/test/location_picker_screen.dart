import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/screens/location_picker_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: SafeArea(child: LocationPickerScreen(initLocation: null)),
      ),
    ),
  );
}
