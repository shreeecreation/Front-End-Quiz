import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiz/src/app/screens/Quiz%20Screen/domain/loaded_quiz_data.dart';
import 'package:quiz/src/core/extensions/colors_extension.dart';
import 'package:quiz/src/core/themes/appcolors.dart';
import 'package:quiz/src/core/themes/appstyles.dart';

import 'domain/quiz_domain.dart';

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
                  var questionsEasy = jsonData[0]["questions_easy"];

                  int randomNumber = Random().nextInt(3);
                  return Column(
                    children: [
                      // ...
                      Expanded(
                        child: PageView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: page,
                          scrollDirection: Axis.horizontal,
                          pageSnapping: true,
                          itemCount: questionsEasy.length,
                          itemBuilder: (context, index) {
                            var question = questionsEasy.values.toList()[index];
                            return OptionWidget(
                                question: question,
                                onTap: () {
                                  print("dasd");
                                  pageIndex = index + 1;
                                  page.animateToPage(
                                    pageIndex,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                });
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

class OptionWidget extends StatefulWidget {
  final Map<String, dynamic> question;
  final VoidCallback onTap;
  const OptionWidget({Key? key, required this.question, required this.onTap}) : super(key: key);

  @override
  State<OptionWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {
  int selectedTileIndex = -2;
  int answerIndex = -1;
  bool isTapped = false;

  @override
  void initState() {
    super.initState();

    answerIndex = int.parse(widget.question["answer"]);
  }

  @override
  Widget build(BuildContext context) {
    String questionText = widget.question["question"];
    List<String> options = List<String>.from(widget.question["options"]);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(questionText, style: AppStyles.text18Px.white, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            SizedBox(
              height: 320,
              child: Card(
                color: AppColors.cardColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                  child: GestureDetector(
                    onTap: widget.onTap,
                    child: ListView.builder(
                      itemCount: options.length,
                      itemExtent: 75,
                      itemBuilder: (context, index) {
                        bool isCorrectAnswer = answerIndex == index;
                        bool isSelected = selectedTileIndex == index;
                        bool isIncorrectSelection = isSelected && !isCorrectAnswer;
                        Color unTappedColor = const Color.fromARGB(138, 0, 0, 0);
                        Color tileColor = isIncorrectSelection
                            ? Colors.red
                            : isSelected || isCorrectAnswer
                                ? Colors.green
                                : const Color.fromARGB(138, 0, 0, 0);

                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(color: isTapped ? tileColor : unTappedColor, borderRadius: BorderRadius.circular(8.0)),
                            child: ListTile(
                              title: Text(options[index], style: AppStyles.text18Px.white),
                              onTap: !isTapped
                                  ? () {
                                      setState(() {
                                        widget.onTap;
                                        isTapped = true;
                                        selectedTileIndex = index;
                                      });
                                    }
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
