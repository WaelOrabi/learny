import 'package:learny_project/features/appointment/domain/entities/get_goals_entity.dart';

class GoalsModel extends GoalsEntity{


  GoalsModel({ required super.data});

  factory GoalsModel.fromJson(Map<String, dynamic> json) {
    return GoalsModel(
      data: List<GoalModel>.from(json['data'].map((x) => GoalModel.fromJson(x)).toList()),
    );
  }
}

class GoalModel extends GoalEntity{


  GoalModel({required super.id, required super.goalName});

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      id: json['id'],
      goalName: json['goal_name'],
    );
  }
}
