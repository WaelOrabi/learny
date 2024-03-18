import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/send_otp_usecase.dart';
import '../../widgets/map_failure_to_message.dart';

part 'send_otp_event.dart';
part 'send_otp_state.dart';

class SendOtpBloc extends Bloc<SendOtpEvent, SendOtpState> {
  final SendOtpUseCase sendOtpUseCase;
  SendOtpBloc({required this.sendOtpUseCase}) : super(SendOtpInitial()) {
    on<SendOtpEvent>((event, emit) async{
      if(event is SendOtpAuthEvent){
        emit(SendOtpLoading());
        final  failureOrUser=await sendOtpUseCase(email: event.email);

        failureOrUser.fold((failure) {
          emit(SendOtpError(message: mapFailureToMessage(failure)));
        }, (r) {
          emit(SendOtpSuccess());
        });
      }
    });
  }
}
