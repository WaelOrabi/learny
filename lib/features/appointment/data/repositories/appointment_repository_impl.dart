import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:learny_project/core/error/exception.dart';
import 'package:learny_project/core/error/failure.dart';
import 'package:learny_project/core/network/network_info.dart';
import 'package:learny_project/features/appointment/data/datasources/appointment_remote_data_source.dart';
import 'package:learny_project/features/appointment/domain/entities/get_goals_entity.dart';
import 'package:learny_project/features/appointment/domain/entities/get_student_appointment_entity.dart';
import 'package:learny_project/features/appointment/domain/entities/get_teacher_appointment_entity.dart';
import 'package:learny_project/features/appointment/domain/entities/get_teacher_appointments_entity.dart';
import 'package:learny_project/features/appointment/domain/entities/update_booking_appointment_entity.dart';
import 'package:learny_project/features/appointment/domain/repositories/appointment_repository.dart';

import '../../domain/entities/booking_appointment_entity.dart';
import '../models/booking_appointment_model.dart';
import '../models/update_booking_appointment_model.dart';
import '../../domain/entities/get_student_appointments_entity.dart';

class AppointmentRepositoryImpl extends AppointmentRepository {
  final NetworkInfo networkInfo;
  final AppointmentRemoteDataSource appointmentRemoteDataSource;

  AppointmentRepositoryImpl(
      {required this.networkInfo, required this.appointmentRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> bookingAppointment(
      {required BookingAppointmentEntity bookingAppointmentEntity}) async {
    final BookingAppointmentModel bookingAppointmentModel =
        BookingAppointmentModel(
            periodId: bookingAppointmentEntity.periodId,
            teacherId: bookingAppointmentEntity.teacherId,
            languageId: bookingAppointmentEntity.languageId,
            levelId: bookingAppointmentEntity.levelId,
            goalId: bookingAppointmentEntity.goalId,
            date: bookingAppointmentEntity.date,
            time: bookingAppointmentEntity.time,
            description: bookingAppointmentEntity.description,
            files: bookingAppointmentEntity.files);
    return _execute(() => appointmentRemoteDataSource.bookingAppointment(
          bookingAppointmentModel: bookingAppointmentModel,
        ));
  }

  @override
  Future<Either<Failure, Unit>> updateBookingAppointment(
      {required UpdateBookingAppointmentEntity
          updateBookingAppointmentEntity}) async {
    final UpdateBookingAppointmentModel updateBookingAppointmentModel =
        UpdateBookingAppointmentModel(
            idAppointment: updateBookingAppointmentEntity.idAppointment,
            teacherId: updateBookingAppointmentEntity.teacherId,
            periodId: updateBookingAppointmentEntity.periodId,
            levelId: updateBookingAppointmentEntity.levelId,
            goalId: updateBookingAppointmentEntity.goalId,
            date: updateBookingAppointmentEntity.date,
            time: updateBookingAppointmentEntity.time,
            description: updateBookingAppointmentEntity.description,
            files: updateBookingAppointmentEntity.files);
    return _execute(() => appointmentRemoteDataSource.updateBookingAppointment(
          updateBookingAppointmentModel: updateBookingAppointmentModel,
        ));
  }

  @override
  Future<Either<Failure, Unit>> deleteAppointment(
      {required String idAppointment}) async {
    return _execute(() => appointmentRemoteDataSource.deleteAppointment(
        idAppointment: idAppointment));
  }

  @override
  Future<Either<Failure, Unit>> changeStateAppointment({required int appointmentId, required int statusId}) async{
    if(await networkInfo.isConnected){
      try{
        return _execute(() => appointmentRemoteDataSource.changeStateAppointment(appointmentId:appointmentId,statusId:statusId));
      }catch(error){
        return _handleError(error);
      }
    }else{
      return Left(OffLineFailure());
    }
  }
  @override
  Future<Either<Failure, GetTeacherAppointmentsEntity>> getTeacherAppointments(
      {required List<String> status, required int numberPage}) async {
    if (await networkInfo.isConnected) {
      try {
        final GetTeacherAppointmentsEntity getTeacherAppointmentsEntity =
            await appointmentRemoteDataSource.getTeacherAppointments(
                status: status, numberPage: numberPage);
        return Right(getTeacherAppointmentsEntity);
      } catch (error) {
        if (error is WrongDataException) {
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, GetTeacherAppointmentEntity>> getTeacherAppointment(
      {required int idAppointment}) async {
    if (await networkInfo.isConnected) {
      try {
        final GetTeacherAppointmentEntity getTeacherAppointmentEntity =
            await appointmentRemoteDataSource.getTeacherAppointment(
                idAppointment: idAppointment);
        return Right(getTeacherAppointmentEntity);
      } catch (error) {
        if (error is WrongDataException) {
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, GetStudentAppointmentEntity>> getStudentAppointment(
      {required int idAppointment}) async {
    if (await networkInfo.isConnected) {
      try {
        final GetStudentAppointmentEntity getStudentAppointmentEntity =
            await appointmentRemoteDataSource.getStudentAppointment(
                idAppointment: idAppointment);
        return Right(getStudentAppointmentEntity);
      } catch (error) {
        if (error is WrongDataException) {
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, GetStudentAppointmentsEntity>> getStudentAppointments(
      {required List<String> status, required int numberPage}) async {
    if (await networkInfo.isConnected) {
      try {
        final GetStudentAppointmentsEntity getStudentAppointmentsEntity =
            await appointmentRemoteDataSource.getStudentAppointments(
                status: status, numberPage: numberPage);
        return Right(getStudentAppointmentsEntity);
      } catch (error) {
        if (error is WrongDataException) {
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }
  @override
  Future<Either<Failure, GoalsEntity>> getGoals() async{
if(await networkInfo .isConnected){
  try{
    final GoalsEntity goalsEntity=await appointmentRemoteDataSource.getGoals();
    return Right(goalsEntity);
  }catch (error) {
    if (error is WrongDataException) {
      return Left(WrongDataFailure(messages: error.messages));
    } else {
      return Left(ServerFailure());
    }
  }
}else{
  return Left(OffLineFailure());
}
  }
  Future<Either<Failure, Unit>> _execute(Future Function() action) async {
    if (await networkInfo.isConnected) {
      try {
        await action();
        return const Right(unit);
      } catch (error) {
        return _handleError(error);
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  Either<Failure, Unit> _handleError(dynamic error) {
    if (error is WrongDataException) {
      return Left(WrongDataFailure(messages: error.messages));
    } else {
      return Left(ServerFailure());
    }
  }





}
