import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learny_project/features/appointment/domain/entities/get_teacher_appointments_entity.dart';

import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/usecases/get_teacher_appointments_usecase.dart';
import 'package:flutter/material.dart';

part 'get_teacher_appointments_event.dart';

part 'get_teacher_appointments_state.dart';

class GetTeacherAppointmentsBloc
    extends Bloc<GetTeacherAppointmentsEvent, GetTeacherAppointmentsState> {
  List<String> list = ['1'];
  final GetTeacherAppointmentsUseCase getTeacherAppointmentsUseCase;


  GetTeacherAppointmentsBloc({required this.getTeacherAppointmentsUseCase})
      : super(GetTeacherAppointmentsInitial()) {
    on<GetTeacherAppointmentsEvent>((event, emit) async {
      if (event is GetTeacherAppointments) {
        emit(GetTeacherAppointmentsLoading());
        final failureOrRequest = await getTeacherAppointmentsUseCase(
            numberPage: event.pageNumber, status: event.statuses);
        failureOrRequest.fold(
                (failure) =>
                emit(GetTeacherAppointmentsError(
                    message: mapFailureToMessage(failure))),
                (appointments) =>
                emit(GetTeacherAppointmentsLoaded(
                    getTeacherAppointmentsEntity: appointments)));
      }
    });
  }
}
