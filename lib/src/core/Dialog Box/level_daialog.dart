import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:quiz/src/app/screens/Quiz%20Screen/domain/loaded_quiz_data.dart';
import 'package:quiz/src/core/Routes/routes.dart';
import 'package:quiz/src/core/extensions/colors_extension.dart';
import 'package:quiz/src/core/themes/appcolors.dart';
import 'package:quiz/src/core/themes/appstyles.dart';

class LevelDialog {
  static Future<Object?> levelDialog(context) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.info,
      closeIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.close, color: AppColors.statusRed)),
      body: Center(
          child: Column(children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: AppColors.cardColor),
          margin: const EdgeInsets.all(10.0),
          child: ListTile(
              title: Text('0. Unchallenging', style: AppStyles.text14PxMedium.white),
              trailing: const Icon(Icons.star, color: Colors.white),
              onTap: () async {
                //Loading the quiz data
                LoadedQuizData.intensity = "Unchallenging";
                Navigator.pop(context);
                await Future.delayed(const Duration(milliseconds: 500));
                Routes.loadingScreenRoutes();
              }),
        ),
        const SizedBox(height: 3),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: AppColors.cardColor),
          margin: const EdgeInsets.all(10.0),
          child: ListTile(
              title: Text('1. Moderate', style: AppStyles.text14PxMedium.white),
              trailing: const SizedBox(
                height: 20,
                width: 50,
                child: Row(children: [Icon(Icons.star, color: Colors.white), Icon(Icons.star, color: Colors.white)]),
              ),
              onTap: () async {
                //Loading the quiz data
                LoadedQuizData.intensity = "Moderate";
                Navigator.pop(context);
                await Future.delayed(const Duration(milliseconds: 500));
                Routes.loadingScreenRoutes();
              }),
        ),
        const SizedBox(height: 3),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: AppColors.cardColor),
          margin: const EdgeInsets.all(10.0),
          child: ListTile(
              title: Text('2. Challenging', style: AppStyles.text14PxMedium.white),
              trailing: const SizedBox(
                height: 20,
                width: 75,
                child: Row(
                  children: [Icon(Icons.star, color: Colors.white), Icon(Icons.star, color: Colors.white), Icon(Icons.star, color: Colors.white)],
                ),
              ),
              onTap: () async {
                //Loading the quiz data
                LoadedQuizData.intensity = "Challening";
                Navigator.pop(context);
                await Future.delayed(const Duration(milliseconds: 500));
                Routes.loadingScreenRoutes();
              }),
        ),
      ])),
      title: 'Choose intensity',
    ).show();
  }
}
