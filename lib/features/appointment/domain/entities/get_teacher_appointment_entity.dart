
import 'package:learny_project/features/auth/domain/entities/user_entity.dart';

class GetTeacherAppointmentEntity {
  GetTeacherAppointmentEntity({
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
    required this.student,
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
  late final UserEntity student;
  late final List<FilesEntity> files;
  late final StudentGoalEntity studentGoal;
  late final StudentLevelEntity studentLevel;
  late final String language;
  late final PeriodEntity period;
}

class FilesEntity {
  FilesEntity({
    required this.id,
    required this.filePath,
  });

  late final int id;
  late final String filePath;
}

class StudentGoalEntity {
  StudentGoalEntity({
    required this.id,
    required this.goalName,
  });

  late final int id;
  late final String goalName;
}

class StudentLevelEntity {
  StudentLevelEntity({
    required this.id,
    required this.levelName,
    required this.levelDescription,
  });

  late final int id;
  late final String levelName;
  late final String? levelDescription;
}

class PeriodEntity {
  PeriodEntity({
    required this.id,
    required this.period,
  });

  late final int id;
  late final String period;
}
