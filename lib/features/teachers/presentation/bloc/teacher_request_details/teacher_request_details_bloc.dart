import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:learny_project/core/error/failure.dart';

import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../data/models/teacher_request_details_model.dart';
import '../../../domain/entities/teacher_request_details_entity.dart';
import '../../../domain/usecases/accept_or_reject_request_teacher.dart';
import '../../../domain/usecases/teacher_request_details_usecase.dart';

part 'teacher_request_details_event.dart';

part 'teacher_request_details_state.dart';

class TeacherRequestDetailsBloc
    extends Bloc<TeacherRequestDetailsEvent, TeacherRequestDetailsState> {
  final TeacherRequestDetailsUseCase teacherRequestDetailsUseCase;

  TeacherRequestDetailsBloc({required this.teacherRequestDetailsUseCase})
      : super(TeacherRequestDetailsInitialState()) {
    on<TeacherRequestDetailsEvent>((event, emit) async {
      if (event is RequestTeacherDetailsEvent) {
        emit(TeacherRequestDetailsLoadingState());

        final Either<Failure, TeacherRequestDetailsEntity> failureOrRequest =
            await teacherRequestDetailsUseCase(teacherId: event.teacherId);
        failureOrRequest.fold((failure) {
          emit(TeacherRequestDetailsFailState(
              message: mapFailureToMessage(failure)));
        }, (requestDetails) {
          emit(TeacherRequestDetailsLoadedState(
              teacherRequestDetailsModel: requestDetails));
        });
      }
    });
  }
}
