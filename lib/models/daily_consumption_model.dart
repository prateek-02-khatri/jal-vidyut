import 'dart:math';

import 'chart_data.dart';

class DailyConsumptionModel {
  Random random = Random();
  List<ChartData> generateData({required int time}) {
    List<ChartData> chartData = [];
    if (time != -1) {
      for (int i=0; i<time; i++) {
        String hour = i.toString();
        int value = random.nextInt(50);
        chartData.add(ChartData(hour, value));
      }
      for (int i=time; i<24; i++) {
        String hour = i.toString();
        chartData.add(ChartData(hour, 0));
      }
      return chartData;
    }
    for (int i=0; i<24; i++) {
      String hour = i.toString();
      int value = random.nextInt(50);
      chartData.add(ChartData(hour, value));
    }
    return chartData;
  }
}