import 'package:flutter/material.dart';

class Button extends StatelessWidget{
  final int number;
  final Function pressed;

  Button(this.number, this.pressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: number > 0?
        Text('The button has been pressed an odd number of times'):
        Text('The button has been pressed an even number of times'),
        onPressed: pressed,
      ),
    );
  }
}
