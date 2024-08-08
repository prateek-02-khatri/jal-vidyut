import 'package:flutter/material.dart';
import 'package:jalvidyut/utils/utils.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({
    super.key,
    required this.size,
    required this.color,
    required this.icon,
    required this.text,
    required this.textColor,
  });

  final double size;
  final Color color;
  final Widget icon;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(2.0, 2.0), //(x,y)
              blurRadius: 5.0,
              spreadRadius: 1
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: icon,
            ),
            Text(
              text,
              style: Utils.customBodyFontStyle(
                fontSize: 20,
                color: textColor
              ),
            )
          ],
        )
      ),
    );
  }
}