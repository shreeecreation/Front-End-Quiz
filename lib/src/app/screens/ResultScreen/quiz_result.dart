import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quiz/src/app/screens/QuizScreen/domain/current_game_details_domain.dart';
import 'package:quiz/src/core/extensions/colors_extension.dart';
import 'package:quiz/src/core/themes/appcolors.dart';
import 'package:quiz/src/core/themes/appstyles.dart';

class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Quiz Report", style: AppStyles.text22PxMedium.white),
        elevation: 0,
      ),
      backgroundColor: AppColors.defaultbackground,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              height: 150,
              child: Card(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: AppColors.cardColor,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: Row(
                        children: [
                          Text(
                            "Total points Scored : ${CurrentGameDetailes.totalPointsCollected}",
                            style: AppStyles.text14PxMedium.white,
                          ),
                          // const CircularPointIndicator(isActive: true),
                          const CircularProgressIndicatorWithPercentage(
                            fullMarks: 100,
                            marks: 40,
                          ),
                        ],
                      )))),
        ]),
      ),
    );
  }
}

class CircularProgressIndicatorWithPercentage extends StatelessWidget {
  final int marks;
  final int fullMarks;
  const CircularProgressIndicatorWithPercentage({
    Key? key,
    required this.marks,
    required this.fullMarks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double percentage = marks / fullMarks * 100;

    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: marks / fullMarks,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            backgroundColor: AppColors.cardColor,
          ),
          Text(
            '${percentage.toStringAsFixed(1)}',
            // style: textStyle,
          ),
        ],
      ),
    );
  }
}
