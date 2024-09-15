import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/utils.dart';

class ElevatedButtonIcon extends StatelessWidget {
  const ElevatedButtonIcon({super.key, required this.buttonName, required this.icon, required this.onPressed});

  final String buttonName;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      icon: Icon(
        icon,
        size: 20,
        color: AppColors.waterColor,
      ),
      label: Text(
        buttonName,
        style: Utils.customTextStyle(
          color: AppColors.waterColor,
          fontSize: 18,
          fontWeight: FontWeight.bold
        ).copyWith(letterSpacing: 1.25),
      ),
    );
  }
}
