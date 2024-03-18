import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/usecases/log_out_usecase.dart';
import 'package:meta/meta.dart';

import '../../widgets/map_failure_to_message.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LogOutUseCase logOutUseCase;
  LogoutBloc({required this.logOutUseCase}) : super(LogoutInitial()) {
    on<LogoutEvent>((event, emit)async {
      if (event is LogoutAuthEvent) {
        emit(LogoutLoading());
        final failureOrUser =
            await logOutUseCase();
        failureOrUser.fold((failure) {
          emit(LogoutError(message: mapFailureToMessage(failure)));
        }, (user) {
          emit(LogoutSuccess());
        });
      }
    });
  }
}
