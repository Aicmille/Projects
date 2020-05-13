import  'package:flutter/material.dart';

import './question.dart';
import './answer.dart';
import './quiz.dart';
import './result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp>{

  final _questions = [
    {'questionText' : 'What is your name?',
      'answers' : [
        {'text': 'Meegan', 'score': 1}, {'text': 'Aidan', 'score': 10},
        {'text': 'Scout', 'score': 1000}, {'text': 'Chandler', 'score': 1000}
      ]},
    {'questionText' : 'What is your quest?',
      'answers' : [
        {'text': 'To find the Holy Grail', 'score': 100},
        {'text': 'To complete skyrim', 'score': 1},
        {'text': 'To make a million dollars', 'score': 50}
      ]},
    {'questionText' : 'What is your favorite color?',
      'answers' : [
        {'text': 'Red', 'score': 10},
        {'text': 'Blue', 'score': 10},
        {'text': 'Purple', 'score': 10}
      ]}
  ];
  var _questionIndex = 0;
  var _totalScore = 0;

  void _answerQuestion(int score){
    _totalScore = _totalScore + score;
    _questionIndex = _questionIndex + 1;
      setState(() {
      print(_questionIndex);
    });
  }

  @override
  Widget build(BuildContext context){

      return MaterialApp(home: Scaffold(
        appBar: AppBar(
            title: Text('Learning Flutter')
        ),
        body: _questionIndex < _questions.length ?
        Quiz(_questions, _answerQuestion, _questionIndex) :
      Result(_totalScore) )
      );
    }
}
