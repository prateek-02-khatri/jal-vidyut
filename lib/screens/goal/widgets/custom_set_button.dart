import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class CustomSetButton extends StatelessWidget {
  const CustomSetButton({super.key, required this.color, required this.onPressed});

  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            minimumSize: const Size(100, 35)
        ),
        child: Text(
          'Apply',
          style: Utils.customTextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
          ).copyWith(letterSpacing: 1.25),
        ),
      ),
    );
  }
}
