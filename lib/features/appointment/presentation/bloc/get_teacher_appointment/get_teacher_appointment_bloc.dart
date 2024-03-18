import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learny_project/features/appointment/domain/entities/get_teacher_appointment_entity.dart';
import 'package:meta/meta.dart';

import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/usecases/change_state_appointment_usecase.dart';
import '../../../domain/usecases/get_teacher_appointment_usecase.dart';

part 'get_teacher_appointment_event.dart';

part 'get_teacher_appointment_state.dart';

class GetTeacherAppointmentBloc
    extends Bloc<GetTeacherAppointmentEvent, GetTeacherAppointmentState> {
  final GetTeacherAppointmentUseCase getTeacherAppointmentUseCase;


  GetTeacherAppointmentBloc(
      {required this.getTeacherAppointmentUseCase})
      : super(GetTeacherAppointmentInitial()) {
    on<GetTeacherAppointmentEvent>((event, emit) async {
      if (event is GetTeacherAppointment) {
        emit(GetTeacherAppointmentLoading());
        final failureOrRequest = await getTeacherAppointmentUseCase(
            idAppointment: event.idAppointment);
        failureOrRequest.fold(
                (failure) =>
                emit(GetTeacherAppointmentError(
                    message: mapFailureToMessage(failure))),
                (appointment) =>
                emit(GetTeacherAppointmentLoaded(
                    getTeacherAppointmentEntity: appointment)));
      }
    });
  }
}
