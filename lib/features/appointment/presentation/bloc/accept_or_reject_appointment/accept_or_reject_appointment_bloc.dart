import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/usecases/change_state_appointment_usecase.dart';

part 'accept_or_reject_appointment_event.dart';
part 'accept_or_reject_appointment_state.dart';

class AcceptOrRejectAppointmentBloc extends Bloc<AcceptOrRejectAppointmentEvent, AcceptOrRejectAppointmentState> {
  final ChangeStateAppointmentUseCase changeStateAppointmentUseCase;
  AcceptOrRejectAppointmentBloc({required this.changeStateAppointmentUseCase}) : super(AcceptOrRejectAppointmentInitial()) {
    on<AcceptOrRejectAppointmentEvent>((event, emit) async{
      if (event is AcceptAppointment) {
        emit(AcceptRequestLoadingState());
        final failureOrRequest = await changeStateAppointmentUseCase(
            appointmentId: event.appointmentId, statusId: event.statusId);
        failureOrRequest.fold((failure) {
          emit(AcceptOrRejectAppointmentErrorState(message: mapFailureToMessage(failure)));
        }, (_) {
          emit(AcceptAppointmentState());
        });
      } else if (event is RejectAppointment) {
        emit(RejectRequestLoadingState());
        final failureOrRequest = await changeStateAppointmentUseCase(
            appointmentId: event.appointmentId, statusId: event.statusId);
        failureOrRequest.fold((failure) {
          emit(AcceptOrRejectAppointmentErrorState(message: mapFailureToMessage(failure)));
        }, (_) {
          emit(RejectAppointmentState());
        });
      }
    });
  }
}
