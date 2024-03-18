import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/entities/user_entity.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/verify_account.dart';
import '../../widgets/map_failure_to_message.dart';

part 'verify_account_event.dart';
part 'verify_account_state.dart';

class VerifyAccountBloc extends Bloc<VerifyAccountEvent, VerifyAccountState> {
  final VerifyAccountUseCase verifyAccountUseCase;
  VerifyAccountBloc({required this.verifyAccountUseCase}) : super(VerifyAccountInitial()) {
    on<VerifyAccountEvent>((event, emit) async{
      if (event is VerifyAccountAuthEvent) {
        emit(VerifyAccountLoading());
        final failureOrUser = await verifyAccountUseCase(email: event.email,code: event.code);
        failureOrUser.fold((failure) {
          emit(VerifyAccountError(message: mapFailureToMessage(failure)));
        }, (user) {
          emit(VerifyAccountSuccess(user: user));
        });
      }
    });
  }
}
