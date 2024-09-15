import 'package:flutter/material.dart';
import '../../../utils/utils.dart';

class CustomToggleButton extends StatelessWidget {
  const CustomToggleButton({super.key, required this.onTap, required this.btnName, required this.color, this.fontSize,});

  final VoidCallback onTap;
  final String btnName;
  final Color color;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        width: 160,
        height: MediaQuery.of(context).size.height / 19,
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          btnName,
          style: Utils.customBodyFontStyle(
            fontSize: fontSize ?? 20,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
