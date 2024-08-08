import 'package:flutter/material.dart';
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