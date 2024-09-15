import 'package:flutter/material.dart';
import 'package:jalvidyut/utils/app_colors.dart';
import 'package:jalvidyut/utils/utils.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonName,
    this.color
  });

  final VoidCallback onPressed;
  final String buttonName;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? AppColors.waterColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        minimumSize: const Size(140, 45),
      ),
      child: Text(
        buttonName,
        style: Utils.customTextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold
        ).copyWith(letterSpacing: 1.25),
      ),
    );
  }
}