
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/forget_password_usecase.dart';
import '../../widgets/map_failure_to_message.dart';

part 'forget_password_event.dart';

part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final ForgetPasswordUseCase forgetPasswordUseCase;
  bool obscureTextNewPassword=true;
  bool obscureTextConfirmNewPassword=true;
  ForgetPasswordBloc({required this.forgetPasswordUseCase})
      : super(ForgetPasswordInitial()) {
    on<ForgetPasswordEvent>((event, emit) async {

      if (event is ForgetPasswordAuthEvent) {
        emit(ForgetPasswordLoading());
        final failureOrUser = await forgetPasswordUseCase(
            email: event.email,
            code: event.code,
            newPassword: event.newPassword,
            confirmNewPassword: event.confirmNewPassword,
        token: event.token
        );
        failureOrUser.fold((failure) {
          emit(ForgetPasswordError(message: mapFailureToMessage(failure)));
        }, (r) {
          emit(ForgetPasswordSuccess());
        });
      }
      if (event is VisibilityNewPasswordForgetPasswordEvent) {
        obscureTextNewPassword = !obscureTextNewPassword; // Toggle the value
        emit(NewPasswordForgetPasswordState(isNewPasswordVisible: obscureTextNewPassword));
      }
      if (event is VisibilityConfirmPasswordForgetPasswordEvent) {
        obscureTextConfirmNewPassword = !obscureTextConfirmNewPassword; // Toggle the value
        emit(ConfirmNewPasswordForgetPasswordState(isConfirmNewPasswordVisible: obscureTextConfirmNewPassword));
      }
    });
  }
}
