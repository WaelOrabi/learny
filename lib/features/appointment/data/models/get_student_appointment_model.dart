import 'package:learny_project/features/appointment/domain/entities/get_student_appointment_entity.dart';
import 'package:learny_project/features/auth/data/models/user_model.dart';

import 'get_teacher_appointment_model.dart';

class GetStudentAppointmentModel extends GetStudentAppointmentEntity {
  GetStudentAppointmentModel({
    required super.data,
  });

  factory GetStudentAppointmentModel.fromJson(Map<String, dynamic> json) {
    return GetStudentAppointmentModel(data: DataModel.fromJson(json['data']));
  }
}

class DataModel extends DataEntity {
  DataModel({
    required super.id,
    required super.date,
    required super.time,
    required super.description,
    required super.appointmentStatus,
    required super.teacher,
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
        files: List.from(json['files'])
            .map((e) => FilesModel.fromJson(e))
            .toList(),
        studentGoal: StudentGoalModel.fromJson(json['student_goal']),
        studentLevel: StudentLevelModel.fromJson(json['student_level']),
        language: json['language'],
        period: PeriodModel.fromJson(json['period']),
        teacher: TeacherModel.fromJson(json['teacher']));
  }
}

class TeacherModel extends TeacherEntity {
  TeacherModel({
    required super.teacherId,
    required super.status,
    required super.rating,
    required super.userInfo,
    required super.createdAt,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
        teacherId: json['teacher_id'],
        status: json['status'],
        rating: json['rating'],
        userInfo: UserModel.fromJson(json['user_info']),
        createdAt: json['created_at']);
  }
}
