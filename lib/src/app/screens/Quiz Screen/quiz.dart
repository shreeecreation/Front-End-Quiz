import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiz/src/app/screens/Quiz%20Screen/domain/loaded_quiz_data.dart';
import 'package:quiz/src/core/extensions/colors_extension.dart';
import 'package:quiz/src/core/themes/appcolors.dart';
import 'package:quiz/src/core/themes/appstyles.dart';

import 'domain/quiz_domain.dart';
import 'model/quiz_model.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PageController page = PageController(initialPage: 0);
    int pageIndex = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(LoadedQuizData.intensity, style: AppStyles.text22PxMedium.white),
        elevation: 0,
      ),
      backgroundColor: AppColors.defaultbackground,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          const Padding(padding: EdgeInsets.only(right: 8.0, left: 8.0), child: Divider(thickness: 1, color: Colors.white)),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.2,
            child: FutureBuilder<String>(
              future: QuizDomain.loadQuizJson(LoadedQuizData.path),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final jsonData = json.decode(snapshot.data!);
                  print(jsonData[0]["questions_easy"]);
                  var questionsEasy = jsonData[0]["questions_easy"];

                  int randomNumber = Random().nextInt(3);
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(jsonData[0]["info"][randomNumber], style: AppStyles.text18PxMedium.white),
                      ),
                      Expanded(
                        child: PageView.builder(
                          physics: const NeverScrollableScrollPhysics(), // Disable scrolling
                          controller: page,
                          scrollDirection: Axis.horizontal,
                          pageSnapping: true,
                          itemCount: questionsEasy.length,
                          itemBuilder: (context, index) {
                            var question = questionsEasy.values.toList()[index];
                            return buildQuestionWidget(question);
                          },
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Failed to load quiz data'),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}

Widget buildQuestionWidget(Map<String, dynamic> question) {
  String questionText = question["question"];
  List<String> options = List<String>.from(question["options"]);
  String answer = question["answer"];

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(questionText,style:AppStyles.text16Px.white),
      // Display options and handle user selection
      // ...
    ],
  );
}
