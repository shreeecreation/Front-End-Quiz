import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:quiz/src/app/screens/HomeScreen/presentation/home_screen.dart';

import 'src/core/themes/themedata.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(title: 'Flutter Demo', theme: appTheme, home: const HomeScreen(), debugShowCheckedModeBanner: false);
  }
}
