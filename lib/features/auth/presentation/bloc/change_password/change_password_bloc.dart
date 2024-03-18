import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/change_password_usecase.dart';
import '../../widgets/map_failure_to_message.dart';

part 'change_password_event.dart';

part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;
  bool obscureTextOldPassword=true;
  bool obscureTextNewPassword=true;
  bool obscureTextConfirmNewPassword=true;
  ChangePasswordBloc({required this.changePasswordUseCase})
      : super(ChangePasswordInitial()) {
    on<ChangePasswordEvent>((event, emit) async {

      if (event is ChangePasswordAuthEvent) {
        emit(ChangePasswordLoading());
        final failureOrUser = await changePasswordUseCase(
            oldPassword: event.oldPassword,
            newPassword: event.newPassword,
            confirmNewPassword: event.confirmNewPassword);
        failureOrUser.fold((failure) {
          emit(ChangePasswordError(message: mapFailureToMessage(failure)));
        }, (r) {
          emit(ChangePasswordSuccess());
        });
      }
      if(event is VisibilityOldPasswordChangePasswordEvent) {
        obscureTextOldPassword=!obscureTextOldPassword;
        emit(VisibilityOldPasswordChangePasswordState(obscureText: obscureTextOldPassword));
      }
      if(event is VisibilityNewPasswordChangePasswordEvent) {
        obscureTextNewPassword=!obscureTextNewPassword;
        emit(VisibilityNewPasswordChangePasswordState(obscureText: obscureTextNewPassword));
      }
      if(event is VisibilityConfirmNewPasswordChangePasswordEvent) {
        obscureTextConfirmNewPassword=!obscureTextConfirmNewPassword;
        emit(VisibilityConfirmNewPasswordChangePasswordState(obscureText: obscureTextConfirmNewPassword));
      }
    });
  }
}
