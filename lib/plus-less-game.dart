import 'dart:math';
import 'package:flutter/material.dart';

class PlusLessGame extends StatefulWidget {
  const PlusLessGame({Key? key}) : super(key: key);

  @override
  _PlusLessGameState createState() => _PlusLessGameState();
}

class _PlusLessGameState extends State<PlusLessGame> {
  int score = 0;
  final int _lowestNumber = 0;
  final int _higherNumber = 9;
  final List<String> _operators = ['+', '-'];
  final rand = new Random();
  int _firstOperand = 0;
  int _secondOperand = 0;
  String _operator = '';
  String message = '';

  void generateOperation() {
    setState(() {
      _firstOperand =
          _lowestNumber + rand.nextInt(_higherNumber - _lowestNumber);
      _secondOperand =
          _lowestNumber + rand.nextInt(_higherNumber - _lowestNumber);

      _operator = _operators[rand.nextInt(_operators.length)];
    });
  }

  int generateGoodAnswer(int firstOperand, int secondOperand, String operator) {
    if (operator == '+') {
      return firstOperand + secondOperand;
    } else {
      return firstOperand - secondOperand;
    }
  }

  List<int> generateAllAnswers(int goodAnswer) {
    List<int> answers = [goodAnswer];

    for (var i = 0; i < 3; i++) {
      int answer;
      do {
        answer = -9 + (new Random()).nextInt(18 - (-9));
      } while (answers.contains(answer) && answer != goodAnswer);
      answers.add(answer);
    }
    return answers..shuffle();
  }

  void onButtonPressed(int answer) {
    if (answer ==
        generateGoodAnswer(_firstOperand, _secondOperand, _operator)) {
      setState(() {
        score++;
        message = 'Bonne réponse 😀';
      });
    } else {
      if (score > 0) {
        setState(() {
          score--;
          message = 'Mauvaise réponse ☹️';
        });
      }
    }
  }

  Widget generateView(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Score: $score',
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$_firstOperand $_operator $_secondOperand = ?",
              style: TextStyle(
                fontSize: 70,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Choisis la bonne réponse')],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ...generateAllAnswers(
                  generateGoodAnswer(_firstOperand, _secondOperand, _operator))
              .map((answer) {
            return MaterialButton(
              child: Text(
                "$answer",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () => onButtonPressed(answer),
              height: 80,
              color: Colors.amber,
              padding: EdgeInsets.all(2),
              elevation: 0,
            );
          }),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(fontSize: 20),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    generateOperation();
    return generateView(context);
  }
}
