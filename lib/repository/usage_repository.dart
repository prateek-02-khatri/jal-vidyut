import '../models/chart_data.dart';

class UsageRepository {

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