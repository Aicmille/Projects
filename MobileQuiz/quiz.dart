import 'package:flutter/material.dart';

import 'question.dart';
import 'answer.dart';

class Quiz extends StatelessWidget{

  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz(this.questions, this.answerQuestion, this.questionIndex);

  @override
  Widget build(BuildContext context){
    return
        Column(
          children: <Widget>[
            Text('The wizard asks:',
              style: TextStyle(fontSize: 28),
              textAlign: TextAlign.center,),
            Question(questions[questionIndex]['questionText']),
            ...(questions[questionIndex]['answers'] as List<Map<String, Object>>).map((answer) {
              return Answer(() => answerQuestion(answer['score']), answer['text']);
            }).toList()
          ],
        );
  }
}
