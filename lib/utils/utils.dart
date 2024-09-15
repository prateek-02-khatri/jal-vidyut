import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/utils/app_colors.dart';

class Utils {
  static customAlertBox({required BuildContext context, required String title}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: customTextStyle(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Ok",
                style: customTextStyle(
                  color: AppColors.waterColor
                ),
              )
            )
          ],
        );
      },
    );
  }

  static showLoadingBox({required BuildContext context, required String title}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Padding(
            padding: const EdgeInsets.only(bottom: 3.0, top: 8.0, left: 6.0, right: 2.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CircularProgressIndicator(
                      color: AppColors.waterColor,
                    ),

                    const SizedBox(width: 25),

                    Expanded(
                      child: Text(
                        title,
                        style: customTextStyle(),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static showSnackBar({
    required String title,
    required String message,
  }) {
    return Get.snackbar(
      title,
      message,
      backgroundColor: Colors.white54,
      colorText: Colors.black,
    );
  }

  static customHeadFontStyle({FontWeight? fontWeight, double? fontSize}) {
    return TextStyle(
      fontFamily: 'Roboto Bold',
      fontWeight: fontWeight ?? FontWeight.normal,
      fontSize: fontSize ?? 20
    );
  }

  static customBodyFontStyle({double? fontSize, FontWeight? fontWeight, Color? color}) {
    return TextStyle(
      fontFamily: 'Roboto Regular',
      fontWeight: fontWeight ?? FontWeight.bold,
      fontSize: fontSize ?? 17,
      color: color ?? Colors.black
    );
  }

  static customTextStyle({double? fontSize, FontWeight? fontWeight, Color? color}) {
    return TextStyle(
      fontFamily: 'Roboto Regular',
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? Colors.black,
    );
  }

}