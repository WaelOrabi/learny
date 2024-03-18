

class AssignWorkingTimeModel  {

   List<WorkingDaysModel> workingDays;
  AssignWorkingTimeModel({required this.workingDays});
  factory AssignWorkingTimeModel.fromJson(Map<String, dynamic> json) {
    List<WorkingDaysModel> workingDays = [];
    json['working_days'].forEach((day) {
      workingDays.add(WorkingDaysModel.fromJson(day));
    });
    return AssignWorkingTimeModel(workingDays: workingDays);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (workingDays != null) {
      data['working_days'] = workingDays.map((day) => day.toJson()).toList();
    }
    return data;
  }
}
  class WorkingDaysModel  {

   List<WorkingTimesModel> workingTimes;
    int dayId;
  WorkingDaysModel({required this.dayId, required this.workingTimes});

  factory WorkingDaysModel.fromJson(Map<String, dynamic> json) {
    List<WorkingTimesModel>workingTimes =  [];
    json['working_times'].forEach((period) {
      workingTimes.add( WorkingTimesModel.fromJson(period));
    });
    return WorkingDaysModel(dayId: json['day_id'], workingTimes: workingTimes);

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day_id'] = dayId;
    if (workingTimes != null) {
      data['working_times'] = workingTimes.map((period) => period.toJson()).toList();
    }
    return data;
  }
}

class WorkingTimesModel  {

 String first;
 String end;
  WorkingTimesModel({required  this.first, required  this.end});

  factory WorkingTimesModel.fromJson(Map<String, dynamic> json) {
    return WorkingTimesModel(first: json['first'], end: json['end']);

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first'] = first;
    data['end'] = end;
    return data;
  }
}
