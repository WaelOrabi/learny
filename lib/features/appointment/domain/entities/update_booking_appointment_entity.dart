import 'package:file_selector/file_selector.dart';

class UpdateBookingAppointmentEntity {
  final String idAppointment;
  final String teacherId;
  final String periodId;
  final String levelId;
  final String goalId;
  final String date;
  final String time;
  final String description;

  final List<String> files;

  UpdateBookingAppointmentEntity(
      {required this.idAppointment,
      required this.teacherId,
      required this.periodId,
      required this.levelId,
     required  this.goalId,
     required  this.date,
     required this.time,
     required this.description,
     required this.files});


}
