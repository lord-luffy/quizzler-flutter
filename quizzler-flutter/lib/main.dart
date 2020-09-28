import 'package:flutter/material.dart';
import 'package:quizzler/final_screen.dart';
import 'quiz_brain.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

QuizBrain quizBrain = QuizBrain();

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  loadFinalScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FinalScreen(),
      ),
    );
  }

  void checkAnswer(String userPickedAnswer) async {
    String correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (quizBrain.isFinished() == false) {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
          quizBrain.increaseScore();
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion();
      } else {
        loadFinalScreen();
        quizBrain.reset();
        scoreKeeper = [];
      }
    });
  }

  Widget answerButton(Color color, String answerName) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: FlatButton(
            color: color,
            child: Text(
              answerName,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              checkAnswer(answerName.toLowerCase());
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        answerButton(Colors.green, 'True'),
        answerButton(Colors.grey, 'Maybe'),
        answerButton(Colors.red, 'False'),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Percentage: ${(quizBrain.getPercentageCorrectAnswers() * 100).toStringAsFixed(1)} %',
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
