import 'package:learny_project/features/appointment/data/models/get_student_appointment_model.dart';
import 'package:learny_project/features/appointment/domain/entities/get_student_appointments_entity.dart';

import '../../../teachers/data/models/techers_model.dart';

class GetStudentAppointmentsModel extends GetStudentAppointmentsEntity {
  GetStudentAppointmentsModel({
    required super.data,
    required super.links,
    required super.meta,
  });


  factory GetStudentAppointmentsModel.fromJson(Map<String, dynamic> json){
    return GetStudentAppointmentsModel(
        data: List.from(json['data']).map((e) => DataModel.fromJson(e)).toList(),
        links: LinksModel.fromJson(json['links']),
        meta: MetaModel.fromJson(json['meta']));
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
    required super.language,
  });


  factory DataModel.fromJson(Map<String, dynamic> json){
    return DataModel(id: json['id'],
        date: json['date'],
        time: json['time'],
        description: json['description'],
        appointmentStatus: json['appointment_status'],
        teacher: TeacherModel.fromJson(json['teacher']),
        language: json['language']);
  }

}
