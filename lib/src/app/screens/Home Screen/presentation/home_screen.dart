import 'package:flutter/material.dart';
import 'package:quiz/src/app/screens/Home%20Screen/domain/language_map.dart';
import 'package:quiz/src/app/screens/Quiz%20Screen/domain/loaded_quiz_data.dart';
import 'package:quiz/src/core/Dialog%20Box/level_daialog.dart';
import 'package:quiz/src/core/extensions/colors_extension.dart';
import 'package:quiz/src/core/themes/appcolors.dart';
import 'package:quiz/src/core/themes/appstyles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Front End Quiz", style: AppStyles.text22PxMedium.white),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.person_outline_sharp)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      drawer: const Drawer(),
      backgroundColor: AppColors.defaultbackground,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
            children: [appBuilder(), const Padding(padding: EdgeInsets.all(8.0), child: Divider(thickness: 1, color: Colors.white)), webBuilder()]),
      ),
    );
  }
}

Widget appBuilder() {
  return Column(
    children: [
      const SizedBox(height: 20),
      Text('"Become a better developer"', style: AppStyles.text18Px.white),
      const SizedBox(height: 20),
      Row(
        children: [const SizedBox(width: 24), Text('App Development', style: AppStyles.text18PxBold.white)],
      ),
      GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16, top: 10),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 0.98, crossAxisCount: 2, crossAxisSpacing: 16.0, mainAxisSpacing: 16.0),
        itemCount: LanguageMap.appMap.length,
        itemBuilder: (BuildContext context, int index) {
          final language = LanguageMap.appMap[index];
          final name = language.keys.first;
          final image = language.values.first;
          return GestureDetector(
            onTap: () {
              LoadedQuizData.path = language.values.last;
              LevelDialog.levelDialog(context);
            },
            child: Card(
              color: AppColors.cardColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(image, width: 64, height: 64, fit: BoxFit.contain),
                  const SizedBox(height: 16),
                  Text(name, style: AppStyles.text18PxMedium.white)
                ],
              ),
            ),
          );
        },
      ),
    ],
  );
}

Widget webBuilder() {
  return Column(
    children: [
      const SizedBox(height: 20),
      Row(children: [const SizedBox(width: 24), Text('Web Development', style: AppStyles.text18PxBold.white)]),
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16, top: 10),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 0.98, crossAxisCount: 2, crossAxisSpacing: 16.0, mainAxisSpacing: 16.0),
        itemCount: LanguageMap.webMap.length,
        itemBuilder: (BuildContext context, int index) {
          final language = LanguageMap.webMap[index];
          final name = language.keys.first;
          final image = language.values.first;
          return GestureDetector(
            onTap: () {
              LevelDialog.levelDialog(context);
            },
            child: Card(
                color: AppColors.cardColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset(image, width: 75, height: 75, fit: BoxFit.contain),
                  const SizedBox(height: 16),
                  Text(name, style: AppStyles.text16PxMedium.white)
                ])),
          );
        },
      ),
    ],
  );
}
