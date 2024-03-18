
import 'package:learny_project/features/auth/data/models/user_model.dart';

import '../../domain/entities/get_teacher_appointment_entity.dart';

class GetTeacherAppointmentModel extends GetTeacherAppointmentEntity {
  GetTeacherAppointmentModel({
    required super.data,
  });

  factory GetTeacherAppointmentModel.fromJson(Map<String, dynamic> json) {
    return GetTeacherAppointmentModel(data: DataModel.fromJson(json['data']));
  }
}

class DataModel extends DataEntity {
  DataModel({
    required super.id,
    required super.date,
    required super.time,
    required super.description,
    required super.appointmentStatus,
    required super.student,
    required super.files,
    required super.studentGoal,
    required super.studentLevel,
    required super.language,
    required super.period,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
        id: json['id'],
        date: json['date'],
        time: json['time'],
        description: json['description'],
        appointmentStatus: json['appointment_status'],
        student: UserModel.fromJson(json['student']),
        files: List.from(json['files'])
            .map((e) => FilesModel.fromJson(e))
            .toList(),
        studentGoal: StudentGoalModel.fromJson(json['student_goal']),
        studentLevel: StudentLevelModel.fromJson(json['student_level']),
        language: json['language'],
        period: PeriodModel.fromJson(json['period']));
  }
}

class FilesModel extends FilesEntity {
  FilesModel({
    required super.id,
    required super.filePath,
  });

  factory FilesModel.fromJson(Map<String, dynamic> json) {
    return FilesModel(id: json['id'], filePath: json['file_path']);
  }
}

class StudentGoalModel extends StudentGoalEntity {
  StudentGoalModel({
    required super.id,
    required super.goalName,
  });

  factory StudentGoalModel.fromJson(Map<String, dynamic> json) {
    return StudentGoalModel(id: json['id'], goalName: json['goal_name']);
  }
}

class StudentLevelModel extends StudentLevelEntity {
  StudentLevelModel({
    required super.id,
    required super.levelName,
    required super.levelDescription,
  });

  factory StudentLevelModel.fromJson(Map<String, dynamic> json) {
    return StudentLevelModel(
        id: json['id'],
        levelName: json['level_name'],
        levelDescription: json['level_description']);
  }
}

class PeriodModel extends PeriodEntity {
  PeriodModel({
    required super.id,
    required super.period,
  });

  factory PeriodModel.fromJson(Map<String, dynamic> json) {
    return PeriodModel(id: json['id'], period: json['period']);
  }
}
