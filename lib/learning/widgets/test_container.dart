import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:langlearn/learning/models/level.dart';
import 'package:langlearn/learning/models/question.dart';
import 'package:langlearn/learning/widgets/result.dart';
import 'package:langlearn/learning/widgets/test.dart';

class TestContainer extends StatefulWidget {
  const TestContainer({super.key, required this.levelInfo});
  final Level levelInfo;
  @override
  State<TestContainer> createState() {
    return _TestContainerState();
  }
}

class _TestContainerState extends State<TestContainer> {
  late Future<List<Question>> _loadedQuestions;
  var currentQuestionIndex = 0;
  Future<List<Question>> _loadQuestions() async {
    final url = Uri.https(
        'languagelearner-22add-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/${widget.levelInfo.lang.toLowerCase()}/level${widget.levelInfo.level.toString()}.json');
    final response = await http.get(url);
    if (response.statusCode >= 400) {
      throw Exception('Failed to fetch grocery items. Please try again later.');
    }
    if (response.body == 'null') {
      return [];
    }
    final Map<String, dynamic> listData = json.decode(response.body);
    final List<Question> loadedQuestions = [];
    for (final item in listData.entries) {
      List<String> options = [];
      for (final op in item.value['options']) {
        options.add(op.toString());
      }
      loadedQuestions.add(
        Question(
          id: item.key,
          ques: item.value['question'],
          options: options,
          answer: item.value['answer'],
        ),
      );
    }
    return loadedQuestions;
  }

  List<String> _selectedAnswers = [];
  void _chooseAnswer(String answer) {
    _selectedAnswers.add(answer);
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadedQuestions = _loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadedQuestions,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text(
            snapshot.error.toString(),
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: Theme.of(context).colorScheme.error),
          );
        }
        if (currentQuestionIndex == snapshot.data!.length) {
          return Result(
              choosedAnswers: _selectedAnswers, qnData: snapshot.data!);
        }
        return Test(
          qn: snapshot.data![currentQuestionIndex],
          onSelect: _chooseAnswer,
        );
      },
    );
  }
}
