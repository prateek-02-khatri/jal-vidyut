import 'package:flutter/material.dart';
import 'package:jalvidyut/utils/app_colors.dart';

class PremiumBox extends StatelessWidget {
  const PremiumBox({
    super.key,
    required this.child,
    required this.width,
  });

  final Widget child;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Stack(
        children: [
          Container(
            height: width/2,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.electricityColor.withOpacity(0.55),
              borderRadius: BorderRadius.circular(15),
              border: const Border.fromBorderSide(BorderSide(
                width: 3,
                color: Colors.black
              )),
            ),
            child: child
          ),

          const Positioned(
            top: 5,
            right: 5,
            child: Icon(
              Icons.workspace_premium_sharp
            ),
          )
        ],
      ),
    );
  }
}
