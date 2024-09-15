class GoalModel {
  final String daily;
  final String weekly;

  GoalModel({
    required this.daily,
    required this.weekly,
  });

  Map<String, dynamic> toMap() {
    return {
      'daily': daily,
      'weekly': weekly,
    };
  }

  factory GoalModel.fromMap(Map<String, dynamic> map) {
    return GoalModel(
      daily: map['daily'] ?? '',
      weekly: map['weekly'] ?? '',
    );
  }
}