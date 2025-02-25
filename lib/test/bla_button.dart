
import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/widgets/inputs/bla_button.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: BlaButton(
            Text('Click Me'),
            onPressed: () {
              print('Button Pressed!');
            },
            icon: Icons.thumb_up,
            isPrimary: true,
          ),
        ),
      ),
    ),
  );
}