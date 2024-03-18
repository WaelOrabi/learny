import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learny_project/features/appointment/domain/entities/get_student_appointment_entity.dart';
import 'package:flutter/material.dart';

import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/usecases/get_student_appointment_usecase.dart';

part 'get_student_appointment_event.dart';

part 'get_student_appointment_state.dart';

class GetStudentAppointmentBloc
    extends Bloc<GetStudentAppointmentEvent, GetStudentAppointmentState> {
  final GetStudentAppointmentUseCase getStudentAppointmentUseCase;

  GetStudentAppointmentBloc({required this.getStudentAppointmentUseCase})
      : super(GetStudentAppointmentInitial()) {
    on<GetStudentAppointmentEvent>((event, emit) async {
      if (event is GetStudentAppointment) {
        emit(GetStudentAppointmentLoading());
        final failureOrRequest = await getStudentAppointmentUseCase(
            idAppointment: event.idAppointment);
        failureOrRequest.fold(
            (failure) => emit(GetStudentAppointmentError(
                message: mapFailureToMessage(failure))),
            (appointment) => emit(GetStudentAppointmentLoaded(
                getStudentAppointmentEntity: appointment)));
      }
    });
  }
}
