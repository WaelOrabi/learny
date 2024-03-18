class GoalsEntity {
  List<GoalEntity> data;

  GoalsEntity({ required this.data});

}

class GoalEntity {

  int id;
  String goalName;

  GoalEntity({required this.id, required this.goalName});

}
