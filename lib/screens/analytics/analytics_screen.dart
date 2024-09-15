import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/components/custom_app_bar.dart';
import 'package:jalvidyut/controller/analytic_controller.dart';
import 'package:jalvidyut/repository/analytic_repository.dart';
import 'package:jalvidyut/screens/analytics/widgets/graph_viewer.dart';
import 'package:jalvidyut/components/icon_container.dart';
import 'package:jalvidyut/utils/app_colors.dart';
import 'package:jalvidyut/utils/utils.dart';

import '../../models/chart_data.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {

  AnalyticRepository analyticRepository = AnalyticRepository();
  AnalyticController controller = Get.put(AnalyticController());

  bool isWater = true;
  List<List<ChartData>> data = [];

  List<String> weekIntervals = [];
  List<double> totalConsumptionForDay = [];
  List<double> previousData = [];

  @override
  void initState() {
    controller.reset();

    data = analyticRepository.getData();
    weekIntervals = analyticRepository.getWeekIntervals();
    totalConsumptionForDay = analyticRepository.totalConsumptionForWeek(data);
    previousData = analyticRepository.compareConsumption(totalConsumptionForDay);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: 'Weekly Analysis'),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Weekly Consumption Report',
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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              width: Get.width,
              height: Get.height * 0.5,
              child: Obx(() =>
                GraphViewer(
                  isWater: isWater,
                  chartData: data,
                  weekIntervals: weekIntervals,
                  totalConsumption: totalConsumptionForDay,
                  previousData: previousData,
                  index: controller.index.value,
                  leftButton: controller.moveLeft,
                  rightButton: controller.moveRight,
                )
              )
            ),
          )

        ],
      ),
    );
  }
}
