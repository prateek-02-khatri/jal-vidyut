import 'package:intl/intl.dart';

import '../models/chart_data.dart';

class AnalyticRepository {

  List<String> days = ['M', 'T', 'W', 'Th', 'F', 'S', 'Su'];

  List<List<int>> dataSet = [
    [360, 400, 390, 555, 645, 785, 830],
    [360, 900, 405, 960, 435, 480, 465],
    [450, 520, 870, 560, 580, 780, 620],
    [720, 600, 810, 810, 870, 360, 930],
  ];

  List<List<ChartData>> getData() {

    List<List<ChartData>> chartData = [];
    List<ChartData> temp = [];

    for (int j=0; j<4; j++) {
      temp = [];
      for (int i=0; i<7; i++) {
        String day = days[i].toString();
        int value = dataSet[j][i];
        temp.add(ChartData(day, value));
      }
      chartData.add(temp);
    }

    return chartData.reversed.toList();
  }

  List<String> getWeekIntervals() {
    List<String> graphTimeLine = [];
    DateFormat dateFormat = DateFormat('dd MMM');
    DateTime currentTime = DateTime.now();

    if (currentTime.weekday < 1) {
      currentTime = currentTime.subtract(Duration(days: currentTime.weekday));
    }

    currentTime = currentTime.subtract(const Duration(days: 6));

    DateTime monday = currentTime.subtract(Duration(days: currentTime.weekday - 1));
    DateTime sunday = monday.add(const Duration(days: 6));

    for (int i=0; i<4; i++) {
      graphTimeLine.add('${dateFormat.format(monday)} - ${dateFormat.format(sunday)}');
      monday = monday.subtract(const Duration(days: 7));
      sunday = sunday.subtract(const Duration(days: 7));
    }

    return graphTimeLine.reversed.toList();
  }

  List<double> totalConsumptionForWeek(List<List<ChartData>> data) {
    List<double> totalConsumption = [];
    for (int week=0; week<data.length; week++) {
      double total = 0;
      for (int day=0; day<data.length; day++) {
        total += data[week][day].y;
      }
      totalConsumption.add(total/1000);
    }
    return totalConsumption;
  }

  List<double> compareConsumption(List<double> totalConsumption) {
    List<double> comparison = [];
    for (int i=1; i<totalConsumption.length; i++) {
      comparison.add(((totalConsumption[i] - totalConsumption[i-1])/totalConsumption[i-1]) * 100);
    }
    return comparison;
  }

}