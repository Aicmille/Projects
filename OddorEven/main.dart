import 'package:flutter/material.dart';
import 'button.dart';
import 'textOut.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState(){
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp>{
  var buttoncount = 0;

  void _pushButton(){

    setState(() {
      buttoncount += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Odd/Even Button')
        ),
        body: TextOutput(buttoncount, _pushButton),
      )
    );
  }
}
