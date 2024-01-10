class Question {
  const Question({
    required this.id,
    required this.ques,
    required this.options,
    required this.answer,
  });
  final String id;
  final String ques;
  final List<String> options;
  final String answer;
}
