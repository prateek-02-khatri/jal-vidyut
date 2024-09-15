import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/controller/goal_controller.dart';

import '../../../utils/utils.dart';

class QuickGoalSelection extends StatelessWidget {
  const QuickGoalSelection({super.key, required this.controller, required this.selectedIndex});

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
            'Instant Usage Goal Selection',
            style: Utils.customBodyFontStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),

          const SizedBox(height: 3),

          Text(
            'Simplify your goal setting by selecting a pre-set consumption level',
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
                'Usage Limit',
                style: Utils.customBodyFontStyle(
                  fontSize: 16
                ),
              ),

              Obx(() {
                try {
                  return DropdownButton<String>(
                    value: selectedIndex == 0 ? controller.selectedDailyGoalTheme.value : controller.selectedWeeklyGoalTheme.value,

                    items: ['Low', 'Medium', 'High', 'Custom'].map((value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: Utils.customTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),
                          )
                      );
                    }).toList(),

                    onChanged: (value) {
                      selectedIndex == 0 ?
                      controller.updateDailyGoalTheme(value!):
                      controller.updateWeeklyGoalTheme(value!);
                    },
                    dropdownColor: Colors.white,
                  );
                }
                catch (e) {
                  return const SizedBox();
                }
              })
            ],
          ),
        ],
      ),
    );
  }
}