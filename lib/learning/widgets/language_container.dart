import 'package:flutter/material.dart';
import 'package:langlearn/learning/models/language.dart';

class LanguageContainer extends StatelessWidget {
  const LanguageContainer({super.key, required this.language,required this.onSelectLanguage});
  final Language language;
  final void Function() onSelectLanguage;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectLanguage,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.secondary.withOpacity(0.55),
                Theme.of(context).colorScheme.secondary.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Hero(
                tag: language.lang,
                child: Image.network(
                  language.flagURL,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                language.lang,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
