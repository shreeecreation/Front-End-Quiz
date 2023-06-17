import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:quiz/src/app/screens/Home%20Screen/domain/language_map.dart';
import 'package:quiz/src/core/Dialog%20Box/level_daialog.dart';
import 'package:quiz/src/core/themes/appcolors.dart';
import 'package:quiz/src/core/themes/appstyles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Front End Quiz", style: AppStyles.text20PxMedium), elevation: 0.1),
      drawer: const Drawer(),
      backgroundColor: AppColors.defaultbackground,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [appBuilder(), webBuilder()]),
      ),
    );
  }

  Widget appBuilder() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text('"Become a better developer"', style: AppStyles.text18Px),
        const SizedBox(height: 20),
        Row(
          children: [const SizedBox(width: 24), Text('App Development', style: AppStyles.text18PxBold)],
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16, top: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.98, crossAxisCount: 2, crossAxisSpacing: 16.0, mainAxisSpacing: 16.0),
          itemCount: LanguageMap.appMap.length,
          itemBuilder: (BuildContext context, int index) {
            final language = LanguageMap.appMap[index];
            final name = language.keys.first;
            final image = language.values.first;
            return GestureDetector(
              onTap: () {
                // LevelDialog.levelDialog(context);
              },
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(image, width: 64, height: 64, fit: BoxFit.contain),
                    const SizedBox(height: 16),
                    Text(name, style: AppStyles.text16PxMedium)
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
        Row(children: [const SizedBox(width: 24), Text('Web Development', style: AppStyles.text18PxBold)]),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16, top: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.98, crossAxisCount: 2, crossAxisSpacing: 16.0, mainAxisSpacing: 16.0),
          itemCount: LanguageMap.webMap.length,
          itemBuilder: (BuildContext context, int index) {
            final language = LanguageMap.webMap[index];
            final name = language.keys.first;
            final image = language.values.first;
            return GestureDetector(
              onTap: () {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.info,
                  body: const Center(
                    child: Text(
                      'If the body is specified, then title and description will be ignored, this allows to 											further customize the dialogue.',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  title: 'This is Ignored',
                  desc: 'This is also Ignored',
                  btnOkOnPress: () {},
                ).show();
              },
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(image, width: 64, height: 64, fit: BoxFit.contain),
                    const SizedBox(height: 16),
                    Text(name, style: AppStyles.text16PxMedium)
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
