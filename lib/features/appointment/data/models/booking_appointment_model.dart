

import 'package:intl/intl.dart';

import '../../domain/entities/booking_appointment_entity.dart';

class BookingAppointmentModel extends BookingAppointmentEntity {
 BookingAppointmentModel(
      {required super.periodId,
        required super.languageId,
      required super.teacherId,
      required super.levelId,
      required super.goalId,
      required super.date,
      required super.time,
      required super.description,
      required super.files});

  Future<Map<String, dynamic>> toJson()async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['period_id'] = periodId;
    data['teacher_id'] = teacherId;
    data['language_id']=languageId;
    data['level_id'] = levelId;
    data['goal_id'] = goalId;
    data['time']=time;
    data['date'] =date ;
    data['description'] = description;
    for (int i = 0; i < files.length; i++) {
      data['files[$i]'] = files[i];
    }
    return data;
  }
}
