import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/components/custom_app_bar.dart';
import 'package:jalvidyut/controller/usage_controller.dart';
import 'package:jalvidyut/models/user_model.dart';
import 'package:jalvidyut/repository/usage_repository.dart';
import 'package:jalvidyut/screens/usage/widgets/graph_viewer.dart';
import 'package:jalvidyut/screens/usage/widgets/set_goal.dart';

import '../../models/chart_data.dart';
import '../../utils/app_colors.dart';
import '../../utils/utils.dart';
import '../../components/icon_container.dart';

class UsageScreen extends StatefulWidget {
  const UsageScreen({super.key, required this.user});

  final UserModel user;

  @override
  State<UsageScreen> createState() => _UsageScreenState();
}

class _UsageScreenState extends State<UsageScreen> {

  final double screenHeight = Get.height;
  final double sizedBoxHeightRatio = 0.035;

  bool isWater = true;
  late UsageController controller;
  UsageRepository usageRepository = UsageRepository();

  List<List<ChartData>> data = [];
  List<String> dayIntervals = [];
  List<int> totalConsumptionForDay = [];
  List<int> previousData = [];

  @override
  void initState() {
    dayIntervals = usageRepository.getDaysInterval();

    controller = Get.put(UsageController(dayIntervals.length-1));
    controller.reset();

    data = usageRepository.getData(n: dayIntervals.length, time: DateTime.now().hour);
    totalConsumptionForDay = usageRepository.totalConsumptionForDay(data);
    previousData = usageRepository.compareConsumption(totalConsumptionForDay);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: 'Daily Usage'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              "Daily Consumption Report",
              style: Utils.customTextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: isWater ? AppColors.waterColor : AppColors.electricityColor
              ),
            ),
          ),

          IconContainer(
            onTap: () {
              setState(() {
                isWater = !isWater;
              });
            },
            isWater: isWater
          ),

          SetGoal(
            isWater: isWater,
            user: widget.user,
            weekData: totalConsumptionForDay,
            dailyData: data.last
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              width: Get.width,
              height: screenHeight * 0.45,
              child: Obx(() =>
                GraphViewer(
                  isWater: isWater,
                  index: controller.index.value,
                  chartData: data,
                  leftButton: controller.moveLeft,
                  rightButton: controller.moveRight,
                  previousData: previousData,
                  totalConsumption: totalConsumptionForDay,
                  dayIntervals: dayIntervals,
                )
              )
            ),
          )

        ],
      ),
    );
  }
}
