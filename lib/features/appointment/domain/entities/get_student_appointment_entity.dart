import 'package:learny_project/features/auth/domain/entities/user_entity.dart';

import 'get_teacher_appointment_entity.dart';

class GetStudentAppointmentEntity {
  GetStudentAppointmentEntity({
    required this.data,
  });
  late final DataEntity data;

}

class DataEntity {
  DataEntity({
    required this.id,
    required this.date,
    required this.time,
    required this.description,
    required this.appointmentStatus,
    required this.teacher,
    required this.files,
    required this.studentGoal,
    required this.studentLevel,
    required this.language,
    required this.period,
  });
  late final int id;
  late final String date;
  late final String time;
  late final String description;
  late final String appointmentStatus;
  late final TeacherEntity teacher;
  late final List<FilesEntity> files;
  late final StudentGoalEntity studentGoal;
  late final StudentLevelEntity studentLevel;
  late final String language;
  late final PeriodEntity period;



}

class TeacherEntity {
  TeacherEntity({
    required this.teacherId,
    required this.status,
    required this.rating,
    required this.userInfo,
    required this.createdAt,
  });
  late final int teacherId;
  late final String status;
  late final double rating;
  late final UserEntity userInfo;
  late final String createdAt;
}



