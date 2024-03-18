import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:learny_project/core/error/failure.dart';
import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/entities/update_booking_appointment_entity.dart';
import '../../../domain/usecases/update_booking_appointment_usecase.dart';

part 'update_booking_appointment_event.dart';

part 'update_booking_appointment_state.dart';

class UpdateBookingAppointmentBloc
    extends Bloc<UpdateBookingAppointmentEvent, UpdateBookingAppointmentState> {
  final UpdateBookingAppointmentUseCase updateBookingAppointmentUseCase;

  UpdateBookingAppointmentBloc({required this.updateBookingAppointmentUseCase})
      : super(UpdateBookingAppointmentInitial()) {
    on<UpdateBookingAppointmentEvent>((event, emit) async {
      if (event is UpdateBookingAppointment) {
        emit(UpdateBookingAppointmentLoading());
        final Either<Failure, Unit> failureOrRequest = await updateBookingAppointmentUseCase(
            updateBookingAppointmentEntity:
                event.updateBookingAppointmentEntity);
        failureOrRequest.fold(
          (failure) => emit(UpdateBookingAppointmentError(
            message: mapFailureToMessage(failure),
          )),
          (r) => emit(UpdateBookingAppointmentLoaded()),
        );
      }
    });
  }
}
