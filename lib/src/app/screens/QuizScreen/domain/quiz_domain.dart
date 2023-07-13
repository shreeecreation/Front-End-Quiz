import 'package:flutter/services.dart' show rootBundle;

class QuizDomain {
  static Future<String> loadQuizJson(String path) async {
    return await rootBundle.loadString('assets/json/$path');
  }
}
