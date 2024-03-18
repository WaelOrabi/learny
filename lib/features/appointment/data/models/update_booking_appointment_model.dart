import '../../domain/entities/update_booking_appointment_entity.dart';

class UpdateBookingAppointmentModel extends UpdateBookingAppointmentEntity{
  UpdateBookingAppointmentModel(
      {required super.idAppointment,
     required super.teacherId,
      required super.periodId,
     required super.levelId,
      required super.goalId,
     required super.date,
     required super.time,
      required super.description,
      required super.files});
  Future<Map<String,dynamic>>toJson()async{
    Map<String,dynamic> data=<String,dynamic>{};
    data['id']=idAppointment;
    data['teacher_id']=teacherId;
    data['period_id']=periodId;
    data['level_id']=levelId;
    data['goal_id']=goalId;
    data['date']=date;
    data['time']=time;
    data['description']=description;
    data['files']=files;
    return data;
  }

}