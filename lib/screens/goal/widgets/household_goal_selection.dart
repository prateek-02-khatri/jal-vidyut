import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/goal_controller.dart';
import '../../../utils/utils.dart';

class HouseholdGoalSelection extends StatelessWidget {
  const HouseholdGoalSelection({super.key, required this.controller, required this.selectedIndex});

  final GoalController controller;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Personalize Your Consumption Goal',
            style: Utils.customBodyFontStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
          ),

          const SizedBox(height: 3),

          Text(
            'Set personalized usage limits tailored to the number of people in your home',
            style: Utils.customBodyFontStyle(
              fontSize: 14.5,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.justify,
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Household Size',
                style: Utils.customBodyFontStyle(
                    fontSize: 16
                ),
              ),

              Obx(() => Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        controller.decreaseHouseHoldSize(selectedIndex);
                      },
                      icon: const Icon(
                          Icons.remove,
                          size: 15,
                          color: Colors.black
                      )
                  ),

                  Text(
                    selectedIndex == 0 ?
                    controller.dailyHouseHoldSize.value.toString() :
                    controller.weeklyHouseHoldSize.value.toString(),
                    style: Utils.customTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    ),
                  ),

                  IconButton(
                      onPressed: () {
                        controller.increaseHouseHoldSize(selectedIndex);
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 15,
                        color: Colors.black,
                      )
                  ),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }
}
