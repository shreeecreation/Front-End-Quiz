import 'package:get/get.dart';
import 'package:quiz/src/app/screens/ResultScreen/quiz_result.dart';
import 'package:quiz/src/core/Loading%20Screen/loading_screen.dart';

class Routes {
  static void loadingScreenRoutes() {
    Get.to(() => const LoadingScreen());
  }

  static void quireResultRoutes() {
    Get.to(() => const QuizResultScreen());
  }
}
