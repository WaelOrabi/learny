import '../../../auth/domain/entities/user_entity.dart';
import '../../../teachers/domain/entities/teachers_entity.dart';

class GetTeacherAppointmentsEntity {
  List<DataEntity> data;
  LinksEntity links;
  MetaEntity meta;

  GetTeacherAppointmentsEntity(
      {required this.data, required this.links, required this.meta});
}

class DataEntity {
  int id;
  String date;
  String time;
  String description;
  String appointmentStatus;
  UserEntity student;
  String language;
  PeriodEntity period;

  DataEntity(
      {required this.id,
      required this.date,
      required this.time,
      required this.description,
      required this.appointmentStatus,
      required this.student,
      required this.language,
      required this.period});
}

class PeriodEntity {
  int id;
  String period;

  PeriodEntity({required this.id, required this.period});
}
