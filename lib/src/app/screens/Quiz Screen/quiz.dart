import 'package:flutter/material.dart';
import 'package:quiz/src/app/screens/Quiz%20Screen/domain/loaded_quiz_data.dart';
import 'package:quiz/src/core/extensions/colors_extension.dart';
import 'package:quiz/src/core/themes/appcolors.dart';
import 'package:quiz/src/core/themes/appstyles.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(LoadedQuizData.intensity, style: AppStyles.text22PxMedium.white),
        elevation: 0,
      ),
      backgroundColor: AppColors.defaultbackground,
      body: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(children: [Padding(padding: EdgeInsets.all(8.0), child: Divider(thickness: 1, color: Colors.white))]),
      ),
    );
  }
}
