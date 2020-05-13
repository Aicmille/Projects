import 'package:flutter/material.dart';

import './question.dart';

    class Answer extends StatelessWidget{

      final Function selectHandler;
      final String answerText;

      Answer(this.selectHandler, this.answerText);

      @override
      Widget build(BuildContext context){
        return Container(
          width: 200,
          child: RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: Text(answerText),
            onPressed: selectHandler,
          )
        );
      }
    }
