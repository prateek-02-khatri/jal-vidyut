import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/models/goal_model.dart';
import 'package:jalvidyut/repository/user_repository.dart';
import 'package:jalvidyut/utils/utils.dart';

import '../models/chart_data.dart';

const int _dailyLow = 350;
const int _dailyMedium = 550;
const int _dailyHigh = 650;

const int _weeklyLow = _dailyLow * 7;
const int _weeklyMedium = _dailyMedium * 7;
const int _weeklyHigh = _dailyHigh * 7;

const double _min = 135;
const double _max = 950;

class GoalController extends GetxController {

  RxDouble min = _min.obs;
  RxDouble max = _max.obs;

  RxDouble dailyValueSlider = (_max - _min).obs;
  RxDouble weeklyValueSlider = (_max - _min).obs;

  RxString selectedDailyGoalTheme = ''.obs;
  RxString selectedWeeklyGoalTheme = ''.obs;

  RxInt dailyHouseHoldSize = 1.obs;
  RxInt weeklyHouseHoldSize = 1.obs;

  RxInt dailyLimit = 700.obs;
  RxInt weeklyLimit = 4900.obs;

  void updateDailySlider(double value) {
    if (value > _max) {
      Utils.showSnackBar(title: 'Lacks in Usage', message: 'The amount of water you are holding may lacks with this household size..!!');
      return;
    }

    dailyValueSlider.value = value;

    dailyHouseHoldSize.value = (value / 135).floor();

    switch (value) {
      case _dailyLow:
        selectedDailyGoalTheme.value = 'Low';
        break;

      case _dailyMedium:
        selectedDailyGoalTheme.value = 'Medium';
        break;

      case _dailyHigh:
        selectedDailyGoalTheme.value = 'High';
        break;

      default:
        selectedDailyGoalTheme.value = 'Custom';
        break;
    }
  }

  void updateWeeklySlider(double value) {
    if (value > _max * 7) {
      Utils.showSnackBar(title: 'Lacks in Usage', message: 'The amount of water you are holding may lacks with this household size..!!');
      return;
    }
    weeklyValueSlider.value = value;

    weeklyHouseHoldSize.value = (value / (135 * 7)).floor();

    switch (value) {
      case _weeklyLow:
        selectedWeeklyGoalTheme.value = 'Low';
        break;

      case _weeklyMedium:
        selectedWeeklyGoalTheme.value = 'Medium';
        break;

      case _weeklyHigh:
        selectedWeeklyGoalTheme.value = 'High';
        break;

      default:
        selectedWeeklyGoalTheme.value = 'Custom';
        break;
    }
  }

  void updateDailyGoalTheme(String value) {
    selectedDailyGoalTheme.value = value;

    switch (value) {
      case 'Low':
        updateDailySlider(_dailyLow.toDouble());
        break;

      case 'Medium':
        updateDailySlider(_dailyMedium.toDouble());
        break;

      case 'High':
        updateDailySlider(_dailyHigh.toDouble());
        break;

      default:
        updateDailySlider(dailyValueSlider.value);
        break;
    }
  }

  void updateWeeklyGoalTheme(String value) {
    selectedWeeklyGoalTheme.value = value;

    switch (value) {
      case 'Low':
        updateWeeklySlider(_weeklyLow.toDouble());
        break;

      case 'Medium':
        updateWeeklySlider(_weeklyMedium.toDouble());
        break;

      case 'High':
        updateWeeklySlider(_weeklyHigh.toDouble());
        break;

      default:
        updateWeeklySlider(weeklyValueSlider.value);
        break;
    }
  }

  void increaseHouseHoldSize(int selectedIndex) {

    if (selectedIndex == 0) {
      int increaseValue = dailyHouseHoldSize.value+1;
      if ((increaseValue * 135) < 950) {
        dailyHouseHoldSize.value += 1;
        updateDailySlider(dailyHouseHoldSize.value * 135);
      } else {
        Utils.showSnackBar(title: 'Lacks in Usage', message: 'The amount of water you are holding may lacks with this household size..!!');
      }
    }
    else {
      int increaseValue = weeklyHouseHoldSize.value+1;
      if ((increaseValue * 135 * 7) < 6650) {
        weeklyHouseHoldSize.value += 1;
        updateWeeklySlider(weeklyHouseHoldSize.value * 135 * 7);
      } else {
        Utils.showSnackBar(title: 'Lacks in Usage', message: 'The amount of water you are holding may lacks with this household size..!!');
      }
    }

  }

  void decreaseHouseHoldSize(int selectedIndex) {
    if (selectedIndex == 0) {
      if (dailyHouseHoldSize.value > 1) {
        dailyHouseHoldSize.value -= 1;
        updateDailySlider(dailyHouseHoldSize.value * 135);
      }
    }
    else {
      if (weeklyHouseHoldSize.value > 1) {
        weeklyHouseHoldSize.value -= 1;
        updateWeeklySlider(weeklyHouseHoldSize.value * 135 * 7);
      }
    }

  }

  void setDailyUsageSystem() {
    min.value = _min;
    max.value = _max;
  }

  void setWeeklyUsageSystem() {
    min.value = _min * 7;
    max.value = _max * 7;
  }

  RxString dailyRecommendation = ''.obs;
  RxString weeklyRecommendation = ''.obs;

  calculateDailyRecommendation(List<ChartData> dailyData, bool isWater) {

    int passedHours = DateTime.now().hour;
    int remainingHours = 24 - passedHours;

    int used = 0;
    for (int i=0; i<passedHours; i++) {
      used += dailyData[i].y;
    }

    if (used > dailyLimit.value) {
      dailyRecommendation.value = "You have exceeded your daily limit..!!";
      return -1;
    }

    double currentAverage = used / passedHours;
    double targetHourlyAverage = dailyLimit.value / 24;

    if (currentAverage.floor() == targetHourlyAverage.floor()) {
      dailyRecommendation.value = "Great job! You're right on track with your daily usage. "
          "Keep maintaining this balance to stay within your daily goals.";
      return;
    }

    if (currentAverage > targetHourlyAverage) {
      int remaining = dailyLimit.value - used;
      double recommendedHourlyUsageForRemainingHours = remaining / remainingHours;

      dailyRecommendation.value =
        "You are exceeding your daily limit! "
        "We recommend reducing your daily usage to $remaining ${isWater ? 'liters' : 'units'} i.e. "
        "${recommendedHourlyUsageForRemainingHours.toStringAsFixed(2)} "
        "${isWater ? 'liters' : 'units'} of ${isWater ? 'water' : 'electricity'} per hour for the next $remainingHours hours.";
    }
    else {
      double toBeUsed = targetHourlyAverage * remainingHours;
      double totalProjectedUsage = toBeUsed + used;
      double saved = dailyLimit.value - totalProjectedUsage;

      dailyRecommendation.value =
        "Great job! You are using less ${isWater ? 'water' : 'electricity'} than your set limit. "
        "If you continue using ${isWater ? 'water' : 'electricity'} with this rate, "
        "you'll save approximately ${saved.toStringAsFixed(2)} ${isWater ? 'liters' : 'units'} today.";
    }
  }

  calculateWeeklyRecommendation(List<int> weekData, bool isWater) {

    if (weekData.length == 1) {
      weeklyRecommendation.value = "Enjoy a fresh start to your weekly usage goals!";
      return;
    }

    int passedDays = weekData.length - 1;
    int remainingDays = 7 - passedDays;

    int used = 0;
    for (int i=0; i<weekData.length-1; i++) {
      used += weekData[i];
    }

    if (used > weeklyLimit.value) {
      weeklyRecommendation.value = "You have exceeded your weekly limit..!!";
      return -1;
    }

    double currentAverage = used / passedDays;
    double targetDailyAverage = weeklyLimit.value / 7;

    if (currentAverage.floor() == targetDailyAverage.floor()) {
      dailyRecommendation.value = "Great job! You're right on track with your weekly usage. "
          "Keep maintaining this balance to stay within your weekly goals.";
      return;
    }

    if (currentAverage > targetDailyAverage) {
      int remaining = weeklyLimit.value - used;
      double recommendedDailyUsageForRemainingDays = remaining / remainingDays;

      String temp = 'per day for the next $remainingDays days';
      weeklyRecommendation.value =
        "You are exceeding your weekly limit! "
        "We recommend reducing your weekly usage to $remaining ${isWater ? 'liters' : 'units'} i.e. "
        "${recommendedDailyUsageForRemainingDays.toStringAsFixed(2)} "
        "${isWater ? 'liters' : 'units'} of ${isWater ? 'water' : 'electricity'} ${remainingDays == 1 ? 'for today' : temp}.";

    }
    else {
      double toBeUsed = targetDailyAverage * remainingDays;
      double totalProjectedUsage = toBeUsed + used;
      double saved = weeklyLimit.value - totalProjectedUsage;

      weeklyRecommendation.value =
          "Great job! You are using less ${isWater ? 'water' : 'electricity'} than your set limit. "
          "If you continue using ${isWater ? 'water' : 'electricity'} with this rate, "
          "you'll save approximately ${saved.toStringAsFixed(2)} ${isWater ? 'liters' : 'units'} this week.";
    }
  }

  UserRepository userRepository = UserRepository();

  fetchData(String email) async {
    GoalModel goalModel = await userRepository.fetchUserGoal(email);
    dailyLimit.value = double.parse(goalModel.daily).toInt();
    weeklyLimit.value = double.parse(goalModel.weekly).toInt();
    updateDailySlider(dailyLimit.value.toDouble());
    updateWeeklySlider(weeklyLimit.value.toDouble());
  }

  updateGoal(context, String email) async {
    Utils.showLoadingBox(context: context, title: 'Updating Usage Limit...');
    await userRepository.updateUserGoal(email, dailyValueSlider.value.toString(), weeklyValueSlider.value.toString());
    Navigator.pop(context);
    Navigator.pop(context);
  }
}