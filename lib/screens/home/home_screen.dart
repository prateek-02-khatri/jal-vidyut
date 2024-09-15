import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/components/custom_app_bar.dart';
import 'package:jalvidyut/models/user_model.dart';
import 'package:jalvidyut/screens/home/widgets/icon_container.dart';
import 'package:jalvidyut/utils/routes/routes.dart';

import '../../utils/app_colors.dart';
import '../../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.user
  });

  final UserModel user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double iconContainerWidth = Get.width * 0.33;
  double sizedBoxRation = 0.055;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Select to view consumption',
              style: Utils.customTextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.waterConsumptionScreen,
                arguments: widget.user
              );
            },

            child: IconContainer(
              size: iconContainerWidth,
              color: AppColors.waterColor,
              text: 'Water',
              textColor: Colors.white,
              icon: Icon(
                Icons.water_drop_sharp,
                color: Colors.white,
                size: iconContainerWidth * 0.5,
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.electricityConsumptionScreen,
                arguments: widget.user
              );
            },

            child: IconContainer(
              size: iconContainerWidth,
              color: AppColors.electricityColor,
              text: 'Electricity',
              textColor: Colors.black,
              icon: FaIcon(
                FontAwesomeIcons.solidLightbulb,
                color: Colors.black,
                size: iconContainerWidth * 0.5,
              ),
            ),
          ),

          const SizedBox(height: 5,)

        ],
      ),
    );
  }
}