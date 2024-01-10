import 'package:flutter/material.dart';
import 'package:langlearn/learning/models/question.dart';

class Result extends StatelessWidget {
  const Result({
    super.key,
    required this.choosedAnswers,
    required this.qnData,
  });
  final List<String> choosedAnswers;
  final List<Question> qnData;

  @override
  Widget build(BuildContext context) {
    final numTotalQns = qnData.length;
    int calcPoints() {
      int marks = 0;
      var index = 0;
      for (var data in qnData) {
        if (data.answer == choosedAnswers[index]) {
          marks++;
        }
        index++;
      }
      return marks;
    }

    final marks = calcPoints();

    return Container(
      margin: const EdgeInsets.all(40),
      child: Column(
        children: [
          Text('You answered $marks out of $numTotalQns questions correctly',style: Theme.of(context).textTheme.headlineLarge,),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Home'),
          )
        ],
      ),
    );
  }
}
