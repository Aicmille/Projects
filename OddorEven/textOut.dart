import 'package:flutter/material.dart';
import 'button.dart';

class TextOutput extends StatelessWidget{
  final int number;
  final Function pressed;

  TextOutput(this.number, this.pressed);

  @override
  Widget build(BuildContext context) {
    return number % 2 == 0
    ? Button(0, pressed)
    : Button(1, pressed);
  }
}
