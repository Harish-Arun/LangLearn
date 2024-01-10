import 'package:flutter/material.dart';
import 'package:langlearn/learning/models/level.dart';
import 'package:langlearn/learning/widgets/test_container.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key, required this.level});
  final Level level;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Learner'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: TestContainer(levelInfo: level),
      ),
    );
  }
}
