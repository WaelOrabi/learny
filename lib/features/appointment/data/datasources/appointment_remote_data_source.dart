import 'package:dartz/dartz.dart';
import 'package:learny_project/features/appointment/data/models/get_student_appointment_model.dart';
import 'package:learny_project/features/appointment/data/models/update_booking_appointment_model.dart';

import '../models/booking_appointment_model.dart';
import '../models/get_goals_model.dart';
import '../models/get_student_appointments_model.dart';
import '../models/get_teacher_appointment_model.dart';
import '../models/get_teacher_appointments_model.dart';




abstract class AppointmentRemoteDataSource{
  Future<Unit>bookingAppointment({required BookingAppointmentModel bookingAppointmentModel});
  Future<Unit>updateBookingAppointment({required UpdateBookingAppointmentModel updateBookingAppointmentModel});
  Future<Unit>deleteAppointment({required String idAppointment});
  Future<GetTeacherAppointmentsModel>getTeacherAppointments({required List<String>status,required int numberPage});
  Future<GetTeacherAppointmentModel>getTeacherAppointment({required int idAppointment});
  Future<GetStudentAppointmentModel>getStudentAppointment({required int idAppointment});
  Future<GetStudentAppointmentsModel>getStudentAppointments({required List<String> status, required int numberPage});
  Future<Unit>changeStateAppointment({required int appointmentId,required int statusId });
  Future<GoalsModel>getGoals();
}