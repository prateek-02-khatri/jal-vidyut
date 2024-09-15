import '../models/chart_data.dart';

class UsageRepository {

  List<List<int>> dataSet = [
    [15, 12, 5, 19, 3, 0, 21, 16, 1, 2, 20, 24, 18, 20, 0, 12, 23, 7, 5, 14, 11, 4, 21, 11], // 284
    [20, 24, 0, 0, 0, 10, 0, 30, 2, 4, 40, 20, 36, 30, 52, 24, 46, 14, 10, 40, 18, 8, 16, 22], // 466
    [13, 0, 6, 0, 49, 16, 34, 19, 49, 41, 20, 13, 20, 36, 39, 22, 47, 14, 5, 14, 28, 49, 14, 24], // 572
    [11, 30, 30, 9, 11, 15, 38, 6, 12, 28, 37, 14, 22, 15, 26, 48, 28, 21, 30, 37, 42, 32, 39, 33], // 614
    [30, 14, 51, 24, 59, 20, 26, 25, 40, 27, 48, 23, 49, 46, 33, 30, 1, 21, 18, 52, 9, 45, 9, 32], // 732
    [45, 40, 60, 21, 29, 36, 7, 50, 31, 10, 52, 12, 12, 47, 42, 59, 52, 41, 25, 46, 39, 63, 0, 61], // 880
    [53, 25, 30, 18, 41, 24, 17, 4, 43, 36, 59, 51, 44, 40, 45, 53, 40, 38, 53, 53, 47, 63, 47, 57], // 981
  ];

  List<List<ChartData>> getData({required int n, required int time}) {
    List<List<ChartData>> chartData = [];
    List<ChartData> data = [];

    for (int j=0; j<n-1; j++) {
      data = [];
      for (int i=0; i<24; i++) {
        String hour = i.toString();
        int value = dataSet[j][i];
        data.add(ChartData(hour, value));
      }
      chartData.add(data);
    }

    data = [];

    for (int i=0; i<time; i++) {
      String hour = i.toString();
      int value = dataSet[n-1][i];
      data.add(ChartData(hour, value));
    }
    for (int i=time; i<24; i++) {
      String hour = i.toString();
      data.add(ChartData(hour, 0));
    }
    chartData.add(data);

    return chartData;
  }

  List<String> getDaysInterval() {
    List<String> dayInterval = [];
    DateTime currentTime = DateTime.now();
    int day = currentTime.weekday;
    while (day >= 1) {
      dayInterval.add(getDayName(day));
      day--;
    }
    return dayInterval.reversed.toList();
  }

  String getDayName(int day) {
    switch (day) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }

  List<int> totalConsumptionForDay(List<List<ChartData>> data) {
    List<int> totalConsumption = [];
    for (int week=0; week<data.length; week++) {
      int total = 0;
      for (int day=0; day<data[0].length; day++) {
        total += data[week][day].y;
      }
      totalConsumption.add(total);
    }
    return totalConsumption;
  }

  List<int> compareConsumption(List<int> totalConsumption) {
    List<int> comparison = [];
    for (int i=1; i<totalConsumption.length; i++) {
      comparison.add(totalConsumption[i] - totalConsumption[i-1]);
    }
    return comparison;
  }

}