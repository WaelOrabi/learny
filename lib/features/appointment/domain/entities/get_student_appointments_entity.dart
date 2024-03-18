
import '../../../teachers/domain/entities/teachers_entity.dart';
import '../../../appointment/domain/entities/get_student_appointment_entity.dart';
class GetStudentAppointmentsEntity {
  GetStudentAppointmentsEntity({
    required this.data,
    required this.links,
    required this.meta,
  });
  late final List<DataEntity> data;
  late final LinksEntity links;
  late final  MetaEntity meta;

}

class DataEntity {
  DataEntity({
    required this.id,
    required this.date,
    required this.time,
    required this.description,
    required this.appointmentStatus,
    required this.teacher,
    required this.language,
  });
  late final int id;
  late final String date;
  late final String time;
  late final String description;
  late final String appointmentStatus;
  late final TeacherEntity teacher;
  late final String language;


}


