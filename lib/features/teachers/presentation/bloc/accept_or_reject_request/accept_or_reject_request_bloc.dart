import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/usecases/accept_or_reject_request_teacher.dart';

part 'accept_or_reject_request_event.dart';

part 'accept_or_reject_request_state.dart';

class AcceptOrRejectRequestBloc
    extends Bloc<AcceptOrRejectRequestEvent, AcceptOrRejectRequestState> {
  final AcceptOrRejectRequestTeacher acceptOrRejectRequestTeacher;

  AcceptOrRejectRequestBloc({required this.acceptOrRejectRequestTeacher})
      : super(AcceptOrRejectRequestInitial()) {
    on<AcceptOrRejectRequestEvent>((event, emit) async {
      if (event is AcceptTeacherRequestEvent) {
        emit(AcceptRequestLoadingState());
        final failureOrRequest = await acceptOrRejectRequestTeacher(
            teacherId: event.teacherId, statusId: event.status);
        failureOrRequest.fold((failure) {
          emit(AcceptOrRejectErrorState(message: mapFailureToMessage(failure)));
        }, (message) {
          emit(AcceptTeacherRequestState(message: message));
        });
      } else if (event is RejectTeacherRequestEvent) {
        emit(RejectRequestLoadingState());
        final failureOrRequest = await acceptOrRejectRequestTeacher(
            teacherId: event.teacherId, statusId: event.status);
        failureOrRequest.fold((failure) {
          emit(AcceptOrRejectErrorState(message: mapFailureToMessage(failure)));
        }, (message) {
          emit(RejectTeacherRequestState(message: message));
        });
      }
    });
  }
}
