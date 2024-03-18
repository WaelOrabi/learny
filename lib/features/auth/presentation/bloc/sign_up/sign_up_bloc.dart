import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:learny_project/features/auth/data/models/user_model.dart';
import 'package:learny_project/features/auth/domain/entities/user_entity.dart';
import 'package:meta/meta.dart';
import '../../../domain/usecases/sign_up_usecase.dart';
import '../../widgets/map_failure_to_message.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;
  String? dropDownValue;
  bool obscureTextPassword = true;
  bool obscureTextConfirmPassword = true;

  SignUpBloc({required this.signUpUseCase}) : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) async {
      if (event is SignUpAuthEvent) {
        emit(SignUpLoading());
        final failureOrUser = await signUpUseCase(user: event.user);
        failureOrUser.fold((failure) {
          emit(SignUpError(message: mapFailureToMessage(failure)));
        }, (r) {
          emit(SignUpSuccess());
        });
      } else if (event is DropDownValueEvent) {
        dropDownValue = event.dropDownValue;
        emit(DropDownValueState(dropDownValue: event.dropDownValue));
      }
      if (event is VisibilityPasswordSignUpEvent) {
        obscureTextPassword = !obscureTextPassword;
        emit(VisibilitySignUpState(isPasswordVisible: obscureTextPassword, isConfirmPasswordVisible: obscureTextConfirmPassword));
      }
      if (event is VisibilityConfirmPasswordSignUpEvent) {
        obscureTextConfirmPassword = !obscureTextConfirmPassword;
        emit(VisibilitySignUpState(isPasswordVisible: obscureTextPassword, isConfirmPasswordVisible: obscureTextConfirmPassword));
      }

    });
  }
}
