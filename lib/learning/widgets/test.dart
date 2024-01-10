import 'package:flutter/material.dart';
import 'package:langlearn/learning/models/question.dart';

class Test extends StatelessWidget {
  const Test({super.key, required this.qn, required this.onSelect});
  final Question qn;
  final void Function(String) onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: [
                Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.55),
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              'Choose the correct option for',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Theme.of(context).colorScheme.tertiary),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              qn.ques,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 11 / 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: qn.options.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () {
                      onSelect(qn.options[index]);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withOpacity(0.8),
                    ),
                    child: Text(
                      qn.options[index],
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color:
                                Theme.of(context).colorScheme.tertiaryContainer,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
            // for (final op in qn.options)
            //   ElevatedButton(
            //     onPressed: () {},
            //     child: Text(
            //       op,
            //       textAlign: TextAlign.center,
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
