import 'package:flutter/material.dart';
import 'package:langlearn/learning/models/level.dart';
import 'package:langlearn/learning/screens/test_screen.dart';

class LevelDetail extends StatelessWidget {
  const LevelDetail({super.key, required this.levelDetail});
  final Level levelDetail;
  void onPressLevel(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TestScreen(level: levelDetail),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Level ${levelDetail.level}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    'Dificulty level : ${levelDetail.difficulty.name[0].toUpperCase() + levelDetail.difficulty.name.substring(1)}'),
                ElevatedButton.icon(
                  onPressed: () {
                    onPressLevel(context);
                  },
                  icon: const Icon(Icons.arrow_circle_right),
                  label: Text(levelDetail.taken ? 'Retry' : 'Start'),
                  style: levelDetail.taken
                      ? ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiaryContainer,
                          foregroundColor:
                              Theme.of(context).colorScheme.tertiary)
                      : ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          foregroundColor:
                              Theme.of(context).colorScheme.secondary),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
