import 'dart:convert';
import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quiz/src/app/screens/QuizScreen/domain/loaded_quiz_data.dart';
import 'package:quiz/src/core/Animation/QuizScreen/heartbeat_animation.dart';
import 'package:quiz/src/core/Routes/routes.dart';
import 'package:quiz/src/core/common/Dialog%20Box/exit_dialog.dart';
import 'package:quiz/src/core/extensions/colors_extension.dart';
import 'package:quiz/src/core/themes/appcolors.dart';
import 'package:quiz/src/core/themes/appstyles.dart';
import 'package:vibration/vibration.dart';

import 'domain/quiz_domain.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PageController page = PageController(
      initialPage: 0,
      viewportFraction: 0.9,
    );
    int pageIndex = 0;

    return WillPopScope(
      onWillPop: () async {
        WarningDialog.levelDialog(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(LoadedQuizData.intensity, style: AppStyles.text22PxMedium.white),
          actions: const [HeartbeatButton(), SizedBox(width: 20)],
          elevation: 0,
        ),
        backgroundColor: AppColors.defaultbackground,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(children: [
            const Padding(padding: EdgeInsets.only(right: 8.0, left: 8.0), child: Divider(thickness: 1, color: Colors.white)),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.1,
              child: FutureBuilder<String>(
                future: QuizDomain.loadQuizJson(LoadedQuizData.path),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final jsonData = json.decode(snapshot.data!);
                    var questionsEasy = jsonData[0][LoadedQuizData.questionMode];
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
                                    if (pageIndex == 10) {
                                      Routes.quireResultRoutes();
                                    }
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 50,
                  child: CircularCountDownTimer(
                    duration: 20,
                    initialDuration: 0,
                    controller: CountDownController(),
                    width: 150,
                    height: 150,
                    ringColor: AppColors.cardColor,
                    ringGradient: null,
                    fillColor: Colors.white,
                    fillGradient: null,
                    backgroundColor: Colors.transparent,
                    strokeWidth: 5.0,
                    textStyle: const TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold),
                    textFormat: CountdownTextFormat.S,
                    isReverse: true,
                    isReverseAnimation: false,
                    isTimerTextShown: true,
                    autoStart: true,
                    onComplete: widget.onTap,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(height: 70, child: Text(questionText, style: AppStyles.text18Px.white, textAlign: TextAlign.center)),
            const SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Card(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                color: AppColors.cardColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Questions : ${widget.totalLength + 1}/10", style: AppStyles.text18Px.white),
                      const SizedBox(height: 15),
                      ListView.builder(
                        shrinkWrap: true,
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
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(color: isTapped ? tileColor : unTappedColor, borderRadius: BorderRadius.circular(8.0)),
                              child: ListTile(
                                title: Text(options[index], style: AppStyles.text18Px.white),
                                onTap: !isTapped
                                    ? () {
                                        if (!isCorrectAnswer) {
                                          Vibration.vibrate(duration: 500, amplitude: 100);
                                        }
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
                    ],
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
