import 'dart:math';

import 'chart_data.dart';

class WeeklyConsumptionModel {
  Random random = Random();
  List<String> days = ['M', 'T', 'W', 'Th', 'F', 'S', 'Su'] ;

  List<ChartData> generateData() {
    List<ChartData> chartData = [];
    for (int i=0; i<7; i++) {
      String day = days[i].toString();
      int value = random.nextInt(900);
      chartData.add(ChartData(day, value));
    }
    return chartData;
  }
}