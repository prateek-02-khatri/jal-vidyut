import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/controller/goal_controller.dart';
import 'package:jalvidyut/utils/utils.dart';

class GoalSlider extends StatelessWidget {
  const GoalSlider({
    super.key,
    required this.controller,
    required this.color,
    required this.selectedIndex,
    required this.isWater,
  });

  final GoalController controller;
  final Color color;
  final int selectedIndex;
  final bool isWater;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Set Usage Limit',
              style: Utils.customBodyFontStyle(
                fontSize: 17,
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Tooltip(
                message: 'Adjust your ${selectedIndex == 0 ? 'daily' : 'weekly'} ${isWater ? 'water' : 'electricity'} usage goal',
                exitDuration: const Duration(milliseconds: 750),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(
                      onPressed: () {
                        selectedIndex == 0 ?
                        controller.updateDailySlider(controller.dailyValueSlider.value-1) :
                        controller.updateWeeklySlider(controller.weeklyValueSlider.value-1);
                      },
                      icon: const Icon(
                        Icons.remove,
                        size: 20,
                      )
                    ),

                    Expanded(
                      child: Slider(
                        value: selectedIndex == 0 ? controller.dailyValueSlider.value : controller.weeklyValueSlider.value,
                        min: controller.min.value,
                        max: controller.max.value,
                        divisions: (controller.max.value - controller.min.value).toInt(),
                        allowedInteraction: SliderInteraction.slideThumb,
                        label: selectedIndex == 0 ? controller.dailyValueSlider.value.round().toString() : controller.weeklyValueSlider.value.round().toString(),
                        activeColor: color,
                        inactiveColor: color.withOpacity(0.35),
                        onChanged: (double value) {
                          selectedIndex == 0 ?
                          controller.updateDailySlider(value) :
                          controller.updateWeeklySlider(value);
                        },
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        selectedIndex == 0 ?
                        controller.updateDailySlider(controller.dailyValueSlider.value+1) :
                        controller.updateWeeklySlider(controller.weeklyValueSlider.value+1);
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 20,
                      )
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10,),

            Center(
              child: Text(
                '${selectedIndex == 0 ? controller.dailyValueSlider.value.round() : controller.weeklyValueSlider.value.round()} ${isWater ? 'liters' : 'watts'}',
                style: Utils.customBodyFontStyle(
                  fontSize: 17,
                ),
              ),
            ),

            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Recommended: 150 ${isWater ? 'liters' : 'watts'}',
                style: Utils.customBodyFontStyle(
                  fontSize: 14,
                  color: Colors.grey
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
