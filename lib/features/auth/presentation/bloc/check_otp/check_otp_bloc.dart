import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/check_otp_usecase.dart';
import '../../widgets/map_failure_to_message.dart';

part 'check_otp_event.dart';
part 'check_otp_state.dart';

class CheckOtpBloc extends Bloc<CheckOtpEvent, CheckOtpState> {
  final CheckOtpUseCase checkOtpUseCase;
  CheckOtpBloc({required this.checkOtpUseCase}) : super(CheckOtpInitial()) {
    on<CheckOtpEvent>((event, emit) async{
      if(event is CheckOtpAuthEvent){
      emit(CheckOtpLoading());
        final  failureOrUser=await checkOtpUseCase(code: event.code,email: event.email);

      failureOrUser.fold((failure) {
        emit(CheckOtpError(message: mapFailureToMessage(failure)));
      }, (token) {
        emit(CheckOtpSuccess(token: token));
      });
      }
    });
  }
}
