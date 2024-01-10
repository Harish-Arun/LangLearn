import 'package:flutter/material.dart';
import 'package:langlearn/learning/data/language_data.dart';
import 'package:langlearn/learning/models/language.dart';
import 'package:langlearn/learning/screens/level_screen.dart';
import 'package:langlearn/learning/widgets/language_container.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  void _selectLanguage(BuildContext context, Language lang) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LevelScreen(selectedLang: lang),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Learner'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final lang in langsData)
            LanguageContainer(
              onSelectLanguage: () {
                _selectLanguage(context, lang);
              },
              language: lang,
            )
        ],
      ),
    );
  }
}
