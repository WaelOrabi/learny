import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../data/models/user_model.dart';
import 'package:meta/meta.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../widgets/map_failure_to_message.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    bool obscureText=true;
    on<LoginEvent>((event, emit) async {
      if (event is LoginAuthEvent) {
        emit(LoginLoading());
        final failureOrUser =
            await loginUseCase(email: event.email, password: event.password);
        failureOrUser.fold((failure) {
          emit(LoginError(message: mapFailureToMessage(failure)));
        }, (user) {
          emit(LoginSuccess(user: user));
        });
      }
      else if (event is ToggleVisibilityLoginEvent) {
        obscureText = !obscureText; // Toggle the value
        emit(PasswordLoginState(isPasswordVisible: obscureText));
      }
    });
  }

}
