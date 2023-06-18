import 'package:flutter/material.dart';
import 'package:quiz/src/app/screens/Quiz%20Screen/quiz.dart';
import 'package:quiz/src/core/themes/appcolors.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )
      ..addListener(() {
        setState(() {}); // Rebuild the widget on every animation tick
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Perform your desired action or fire the event here
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return const QuizScreen();
          })));
        }
      });
    _animationController.forward(); // Start the animation
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double get _progressValue => _animationController.value * 100; // Calculate progress value from 0 to 100

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            height: 5,
            child: LinearProgressIndicator(value: _progressValue / 100, color: AppColors.cardColor),
          ),
        ),
      ),
    );
  }
}
