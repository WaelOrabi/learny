import 'package:learny_project/features/auth/data/models/user_model.dart';

import '../../../teachers/data/models/techers_model.dart';
import '../../domain/entities/get_teacher_appointments_entity.dart';

class GetTeacherAppointmentsModel extends GetTeacherAppointmentsEntity {
  GetTeacherAppointmentsModel(
      {required super.data, required super.links, required super.meta});

  factory GetTeacherAppointmentsModel.fromJson(Map<String, dynamic> json) {
    return GetTeacherAppointmentsModel(
        data: List<DataModel>.from(
            json["data"].map((item) => DataModel.fromJson(item))),
        links: LinksModel.fromJson(json["links"]),
        meta: MetaModel.fromJson(json["meta"]));
  }
}

class DataModel extends DataEntity {
  DataModel(
      {required super.id,
      required super.date,
      required super.time,
      required super.description,
      required super.appointmentStatus,
      required super.student,
      required super.language,
      required super.period});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
        id: json['id'],
        date: json['date'],
        time: json['time'],
        description: json['description'],
        appointmentStatus: json['appointment_status'],
        student: UserModel.fromJson(json['student']),
        language: json['language'],
        period: PeriodModel.fromJson(json['period']));
  }
}

class PeriodModel extends PeriodEntity {
  PeriodModel({required super.id, required super.period});

  factory PeriodModel.fromJson(Map<String, dynamic> json) {
    return PeriodModel(id: json['id'], period: json['period']);
  }
}
