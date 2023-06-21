import 'dart:convert';
import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
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
            height: MediaQuery.of(context).size.height / 1.1,
            child: FutureBuilder<String>(
              future: QuizDomain.loadQuizJson(LoadedQuizData.path),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final jsonData = json.decode(snapshot.data!);
                  var questionsEasy = jsonData[0]["questions_easy"];
                  int randomNumber = Random().nextInt(3);
                  var infoText = jsonData[0]["info"];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ...
                      const SizedBox(height: 15),
                      Text(infoText[randomNumber], style: AppStyles.text14Px.white, textAlign: TextAlign.center),
                      const SizedBox(height: 10),

                      const SizedBox(width: 10),
                      Tooltip(
                        richMessage: const TextSpan(
                          text: 'I am a rich tooltip. ',
                          style: TextStyle(color: Colors.white),
                          children: <InlineSpan>[
                            TextSpan(text: 'I am another span of this rich tooltip', style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 8),
                            const Icon(Icons.info, color: Colors.green),
                            const SizedBox(width: 10),
                            Text("Do you know ?", style: AppStyles.text16Px.white)
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),

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
                                  pageIndex = index + 1;
                                  page.animateToPage(pageIndex, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                                },
                                totalLength: index);
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
  final int totalLength;
  const OptionWidget({Key? key, required this.question, required this.onTap, required this.totalLength}) : super(key: key);

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("${widget.totalLength + 1}/10", style: AppStyles.text18Px.white),
                SizedBox(
                  height: 50,
                  child: CircularCountDownTimer(
                    duration: 20``, // Duration in seconds
                    initialDuration: 0, // Initial duration (set to 0 for no initial progress)
                    controller: CountDownController(), // Create a CountDownController instance
                    width: 150, // Width of the circular progress indicator
                    height: 150, // Height of the circular progress indicator
                    ringColor: Colors.green, // Color of the outer ring
                    ringGradient: null, // Gradient color for the outer ring (optional)
                    fillColor: Colors.white, // Color for the filling of the progress indicator
                    fillGradient: null, // Gradient color for the filling of the progress indicator (optional)
                    backgroundColor: Colors.transparent, // Color of the background (optional)
                    strokeWidth: 5.0, // Width of the circular progress indicator's ring
                    textStyle: const TextStyle(
                        fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold), // Text style for the remaining time (optional)
                    textFormat: CountdownTextFormat.S, // Format for displaying the remaining time (optional)
                    isReverse: true, // Set to true for countdown animation (optional)
                    isReverseAnimation: false, // Set to true for reverse countdown animation (optional)
                    isTimerTextShown: true, // Set to false to hide the remaining time (optional)
                    autoStart: true, // Set to false to manually control the start of the timer (optional)
                    onComplete: widget.onTap,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(questionText, style: AppStyles.text18Px.white, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            SizedBox(
              height: 320,
              child: Card(
                color: AppColors.cardColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
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
            const SizedBox(height: 20),
            isTapped
                ? Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ElevatedButton(
                        onPressed: widget.onTap,
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.cardColor, shape: const CircleBorder()),
                        child: const Icon(Icons.keyboard_double_arrow_right_outlined)),
                  )
                : const Text(""),
          ],
        ),
      ),
    );
  }
}
