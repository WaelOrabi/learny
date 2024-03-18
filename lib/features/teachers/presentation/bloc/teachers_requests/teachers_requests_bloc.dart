import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/entities/teachers_requests.dart';
import '../../../domain/usecases/get_all_requests_teachers.dart';

part 'teachers_requests_event.dart';
part 'teachers_requests_state.dart';

class TeachersRequestsBloc extends Bloc<TeachersRequestsEvent, TeachersRequestsState> {
  GetAllRequestsTeachersUseCase getAllRequestsTeachersUseCase;
  TeachersRequestsBloc({required this.getAllRequestsTeachersUseCase}) : super(TeachersRequestsInitial()) {
    on<TeachersRequestsEvent>((event, emit)async {
      if(event is GetAllTeachersRequestsEvent){
        emit(GetAllTeachersRequestsLoading());
        final failureOrTeachersRequests =
            await getAllRequestsTeachersUseCase(statuses: event.statuses);
        failureOrTeachersRequests.fold((failure) {
          emit(GetAllTeachersRequestsError(mapFailureToMessage(failure)));
        }, (teacherRequests) {
          emit(GetAllTeachersRequestsSuccess(list: teacherRequests));
        });
      }
    });
  }
}
