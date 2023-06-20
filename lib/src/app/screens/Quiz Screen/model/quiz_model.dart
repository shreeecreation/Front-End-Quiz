class Quiz {
  final List<String> info;
  final Map<String, QuestionSet> questionsEasy;
  final Map<String, QuestionSet> questionsMedium;
  final Map<String, QuestionSet> questionsHard;

  Quiz({
    required this.info,
    required this.questionsEasy,
    required this.questionsMedium,
    required this.questionsHard,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      info: List<String>.from(json['info']),
      questionsEasy: _parseQuestionSet(json['questions_easy']),
      questionsMedium: _parseQuestionSet(json['questions_medium']),
      questionsHard: _parseQuestionSet(json['questions_hard']),
    );
  }

  static Map<String, QuestionSet> _parseQuestionSet(Map<String, dynamic> json) {
    final Map<String, QuestionSet> questionSet = {};
    json.forEach((key, value) {
      questionSet[key] = QuestionSet.fromJson(value);
    });
    return questionSet;
  }
}

class QuestionSet {
  final String question;
  final List<String> options;
  final String answer;

  QuestionSet({
    required this.question,
    required this.options,
    required this.answer,
  });

  factory QuestionSet.fromJson(Map<String, dynamic> json) {
    return QuestionSet(
      question: json['question'],
      options: List<String>.from(json['options']),
      answer: json['answer'],
    );
  }
}
