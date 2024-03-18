import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failure.dart';
import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/entities/teacher_entity.dart';
import '../../../domain/entities/teachers_entity.dart';
import '../../../domain/usecases/get_teacher_usecase.dart';

part 'get_teacher_event.dart';
part 'get_teacher_state.dart';

class GetTeacherBloc extends Bloc<GetTeacherEvent, GetTeacherState> {
  GetTeacherUseCase getTeacherUseCase;
  GetTeacherBloc({required this.getTeacherUseCase}) : super(GetTeacherInitialState()) {
    on<GetTeacherEvent>((event, emit) async{
      if (event is GetTeacher) {
        emit(GetTeacherLoadingState());
        final Either<Failure, TeacherEntity> failureOrRequest =
        await getTeacherUseCase(
            teacherId: event.teacherId);
        failureOrRequest.fold(
                (failure) => emit(GetTeacherErrorState(
              message: mapFailureToMessage(failure),
            )),
                (teacher) => emit(
              GetTeacherSuccessState(teacher: teacher),
            ));
      }
    });
  }
}
