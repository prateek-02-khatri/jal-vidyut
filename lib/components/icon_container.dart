import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/app_colors.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({
    super.key,
    required this.isWater,
    required this.onTap,
  });

  final bool isWater;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isWater ? AppColors.waterColor : AppColors.electricityColor,
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
          child: isWater ?
          const Icon(
            Icons.water_drop_sharp,
            color: Colors.white,
            size: 35,
          ) :
          const FaIcon(
            FontAwesomeIcons.solidLightbulb,
            color: Colors.black,
            size: 28,
          ),
        ),
      ),
    );
  }
}