import 'package:flutter/material.dart';
import 'package:langlearn/learning/data/level_data.dart';
import 'package:langlearn/learning/models/language.dart';
import 'package:langlearn/learning/widgets/level_details.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key, required this.selectedLang});
  final Language selectedLang;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Learner'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    selectedLang.lang,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.network(
                    selectedLang.flagURL,
                    width: 50,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Text(
                'Test your level of proficiency...',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            for (var level in levels[selectedLang.lang]!)
              LevelDetail(
                levelDetail: level,
              ),
          ],
        ),
      ),
      // child: Text(selectedLang.lang),
    );
  }
}
