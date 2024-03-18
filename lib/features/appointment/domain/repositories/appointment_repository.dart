import 'package:dartz/dartz.dart';
import 'package:learny_project/core/error/failure.dart';
import 'package:learny_project/features/appointment/domain/entities/get_student_appointment_entity.dart';
import 'package:learny_project/features/appointment/domain/entities/get_teacher_appointments_entity.dart';
import 'package:learny_project/features/appointment/domain/entities/update_booking_appointment_entity.dart';

import '../entities/booking_appointment_entity.dart';
import '../entities/get_goals_entity.dart';
import '../entities/get_teacher_appointment_entity.dart';
import '../entities/get_student_appointments_entity.dart';



abstract class AppointmentRepository{
  Future<Either<Failure,Unit>>bookingAppointment({required BookingAppointmentEntity bookingAppointmentEntity});
  Future<Either<Failure,Unit>>updateBookingAppointment({required UpdateBookingAppointmentEntity updateBookingAppointmentEntity});
  Future<Either<Failure,Unit>>deleteAppointment({required String idAppointment});
  Future<Either<Failure,GetTeacherAppointmentsEntity>>getTeacherAppointments({required List<String>status,required int numberPage});
  Future<Either<Failure,GetTeacherAppointmentEntity>>getTeacherAppointment({required int idAppointment});
  Future<Either<Failure, GetStudentAppointmentEntity>>getStudentAppointment({required int idAppointment});
  Future<Either<Failure,GetStudentAppointmentsEntity>>getStudentAppointments({required List<String>status, required int numberPage});
  Future<Either<Failure,Unit>>changeStateAppointment({required int appointmentId,required int statusId });
  Future<Either<Failure,GoalsEntity>>getGoals();
}