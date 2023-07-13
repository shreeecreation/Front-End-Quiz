import 'package:quiz/src/app/screens/QuizScreen/domain/loaded_quiz_data.dart';

class CurrentGameDetailes {
  // answers of each questions in a list
  // questions type coming from the laoded quiz path
  // total marks scroed
  // total error
  // total timed used to clear the test

  static List<String> answerList = [];
  static String questionIntensity = LoadedQuizData.intensity;
  static int totalPointsCollected = 0;
  static int totalError = 0;
  static int gameDuration = 0;

  static void resetDetails() {
    answerList.clear();
    questionIntensity = "";
    totalPointsCollected = 0;
    totalError = 0;
    gameDuration = 0;
  }
}
