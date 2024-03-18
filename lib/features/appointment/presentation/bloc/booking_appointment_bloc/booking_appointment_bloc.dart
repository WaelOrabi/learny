import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/entities/attachments_entity.dart';
import '../../../domain/entities/booking_appointment_entity.dart';
import '../../../domain/usecases/booking_appointment_usecase.dart';

part 'booking_appointment_event.dart';

part 'booking_appointment_state.dart';

class BookingAppointmentBloc
    extends Bloc<BookingAppointmentEvent, BookingAppointmentState> {
  final BookingAppointmentUseCase bookingAppointmentUseCase;
  List<AttachmentsEntity> attachments=[AttachmentsEntity(index: 0, path: '')];
XFile imageFile=XFile("");
  BookingAppointmentBloc({required this.bookingAppointmentUseCase})
      : super(BookingAppointmentInitial()) {
    on<BookingAppointmentEvent>((event, emit) async {
      if (event is BookingAppointment) {
        emit(BookingAppointmentLoading());
        final Either<Failure, Unit> failureOrRequest =
            await bookingAppointmentUseCase(
                bookingAppointmentEntity: event.bookingAppointmentEntity);
        failureOrRequest.fold(
          (failure) => emit(BookingAppointmentError(
            message: mapFailureToMessage(failure),
          )),
          (r) => emit(BookingAppointmentLoaded()),
        );
      }else if (event is DeleteAttachments) {

          attachments.removeAt(event.attachmentsId);


        emit(DeleteAttachmentsState(attachments: List.from(attachments)));
      }else if (event is AddAttachments) {
        final newAttachment = AttachmentsEntity(index: attachments.length, path: '');
        attachments.add(newAttachment);
        emit(AddAttachmentsState(attachments: List.from(attachments)));
      }
    });
  }
}
