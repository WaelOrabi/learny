import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learny_project/features/appointment/domain/entities/get_student_appointments_entity.dart';
import 'package:meta/meta.dart';

import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/usecases/get_student_appointments_usecase.dart';

part 'get_student_appointments_event.dart';

part 'get_student_appointments_state.dart';

class GetStudentAppointmentsBloc
    extends Bloc<GetStudentAppointmentsEvent, GetStudentAppointmentsState> {
  final GetStudentAppointmentsUseCase getStudentAppointmentsUseCase;
  List<String>list=['1'];
  GetStudentAppointmentsBloc({required this.getStudentAppointmentsUseCase})
      : super(GetStudentAppointmentsInitial()) {
    on<GetStudentAppointmentsEvent>((event, emit) async {
      if (event is GetStudentAppointments) {
        emit(GetStudentAppointmentsLoading());
        final failureOrRequest = await getStudentAppointmentsUseCase(
            status: event.status, numberPage: event.numberPage);
        failureOrRequest.fold(
            (failure) => emit(GetStudentAppointmentsError(
                message: mapFailureToMessage(failure))),
            (appointments) => emit(GetStudentAppointmentsLoaded(
                getStudentAppointmentsEntity: appointments)));
      }
    });
  }
}
