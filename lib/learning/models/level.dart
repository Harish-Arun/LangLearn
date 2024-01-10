enum Difficulty { easy, moderate, hard }

class Level {
  const Level({
    required this.lang,
    required this.level,
    required this.difficulty,
    required this.taken,
  });
  final String lang;
  final int level;
  final Difficulty difficulty;
  final bool taken;
}
