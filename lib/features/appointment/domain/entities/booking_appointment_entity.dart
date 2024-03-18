import 'package:file_selector/file_selector.dart';

class BookingAppointmentEntity {
  final String teacherId;
  final String periodId;
  final String languageId;
  final String levelId;
  final String goalId;
  final String date;
  final String time;
  final String description;

  final List<String> files;

  BookingAppointmentEntity(
      {
        required this.teacherId,
        required this.periodId,
        required this.levelId,
        required this.languageId,
        required  this.goalId,
        required  this.date,
        required this.time,
        required this.description,
        required this.files});


}
