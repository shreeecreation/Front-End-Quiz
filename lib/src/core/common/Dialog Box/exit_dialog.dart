import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:quiz/src/core/themes/appcolors.dart';
import 'package:quiz/src/core/themes/appstyles.dart';

class WarningDialog {
  static Future<Object?> levelDialog(context) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.info,
      closeIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.system_security_update_warning_rounded, color: AppColors.statusRed)),
      body: Center(
          child: SizedBox(
              height: 150,
              child: Column(children: [
                Text("Game on progress \n Do you sure want to exit this ?", textAlign: TextAlign.center, style: AppStyles.text16PxSemiBold),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await Future.delayed(const Duration(milliseconds: 500));
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: const Text("Yes")),
                    const SizedBox(width: 20),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: const Text("No")),
                  ],
                )
              ]))),
      title: 'Warning',
    ).show();
  }
}
