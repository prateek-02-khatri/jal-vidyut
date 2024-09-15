import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/components/custom_app_bar.dart';
import 'package:jalvidyut/controller/goal_controller.dart';
import 'package:jalvidyut/models/chart_data.dart';
import 'package:jalvidyut/models/user_model.dart';
import 'package:jalvidyut/screens/goal/widgets/custom_set_button.dart';
import 'package:jalvidyut/screens/goal/widgets/custom_toggle_button.dart';
import 'package:jalvidyut/screens/goal/widgets/household_goal_selection.dart';
import 'package:jalvidyut/screens/goal/widgets/quick_goal_selection.dart';
import 'package:jalvidyut/utils/utils.dart';

import '../../utils/app_colors.dart';
import 'widgets/goal_slider.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({
    super.key,
    required this.isWater,
    required this.user,
    required this.weekData,
    required this.dailyData,
  });

  final bool isWater;
  final UserModel user;
  final List<ChartData> dailyData;
  final List<int> weekData;

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {

  late Color uiColor;
  late Color recommendationColor;

  int selectedIndex = 0;
  int selectedGoalSystem = 0;

  GoalController controller = Get.put(GoalController());

  @override
  void initState() {

    uiColor = widget.isWater ? AppColors.waterColor : AppColors.electricityColor;

    controller.setDailyUsageSystem();
    controller.fetchData(widget.user.email);

    dynamic dailyResult = controller.calculateDailyRecommendation(widget.dailyData, widget.isWater);


    dynamic weeklyResult = controller.calculateWeeklyRecommendation(widget.weekData, widget.isWater);
    recommendationColor = weeklyResult == -1 ? Colors.red : Colors.grey;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: 'Set Goal'),

      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // Top Heading
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top: 8.0),
              child: Center(
                child: Text(
                  'Set Your ${selectedIndex == 0 ? 'Daily' : 'Weekly'} ${widget.isWater ? 'Water' : 'Electricity'} Usage Goal',
                  style: Utils.customBodyFontStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Toggle Buttons (Daily and Weekly)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomToggleButton(
                  onTap: () {
                    if (selectedIndex != 0) {
                      setState(() {
                        selectedIndex = 0;
                        controller.setDailyUsageSystem();
                      });
                    }
                  },
                  btnName: 'Daily',
                  color: selectedIndex == 0 ? uiColor.withOpacity(0.65) : uiColor.withOpacity(0.35)
                ),

                CustomToggleButton(
                    onTap: () {
                      if (selectedIndex != 1) {
                        setState(() {
                          selectedIndex = 1;
                          controller.setWeeklyUsageSystem();
                        });
                      }
                    },
                    btnName: 'Weekly',
                    color: selectedIndex == 1 ? uiColor.withOpacity(0.65) : uiColor.withOpacity(0.35)
                ),
              ],
            ),
            const SizedBox(height: 25),

            // Slider for setting the water goal
            GoalSlider(
              controller: controller,
              color: uiColor,
              selectedIndex: selectedIndex,
              isWater: widget.isWater,
            ),
            const SizedBox(height: 30),

            // Goal Setting Method
            Center(
              child: Text(
                'Select Goal Setting Method',
                style: Utils.customBodyFontStyle(
                  fontSize: 17,
                )
              ),
            ),
            const SizedBox(height: 20),

            // Toggle Buttons (Selection Mode)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomToggleButton(
                  onTap: () {
                    if (selectedGoalSystem != 0) {
                      setState(() {
                        selectedGoalSystem = 0;
                      });
                    }
                  },
                  btnName: 'Quick Selection',
                  color: selectedGoalSystem == 0 ? uiColor.withOpacity(0.65) : uiColor.withOpacity(0.35),
                  fontSize: 14,
                ),

                CustomToggleButton(
                  onTap: () {
                    if (selectedGoalSystem != 1) {
                      setState(() {
                        selectedGoalSystem = 1;
                      });
                    }
                  },
                  btnName: 'Household Size Based',
                  color: selectedGoalSystem == 1 ? uiColor.withOpacity(0.65) : uiColor.withOpacity(0.35),
                  fontSize: 14,
                ),
              ],
            ),
            const SizedBox(height: 30),

            selectedGoalSystem == 0 ?
            QuickGoalSelection(
              controller: controller,
              selectedIndex: selectedIndex,
            ) :
            HouseholdGoalSelection(
              controller: controller,
              selectedIndex: selectedIndex,
            ),

            const Spacer(),

            Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Center(
                  child: Text(
                    selectedIndex == 0 ?
                    controller.dailyRecommendation.value :
                    controller.weeklyRecommendation.value,
                    style: Utils.customBodyFontStyle(
                        fontSize: 14,
                        color: selectedIndex == 0 ?
                          Colors.grey :
                          recommendationColor
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ),

            const Spacer(),

            CustomSetButton(
              color: uiColor,
              onPressed: () {
                // controller.calculateDailyRecommendation(widget.dailyData, widget.isWater);
                controller.updateGoal(context, widget.user.email);
              },
            ),

            const SizedBox(height: 1,)
          ],
        ),
      ),
    );
  }
}
