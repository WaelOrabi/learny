
import 'package:learny_project/features/home/domain/entities/statistics_entity.dart';

class StatisticsModel extends StatisticsEntity{


  StatisticsModel({required super.teacher, required super.user, required super.appointment, required super.content});

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      teacher: json['teacher'],
      user: json['user'],
      appointment: json['appointment'],
      content: json['content'],
    );
  }
}
