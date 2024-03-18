import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learny_project/features/home/data/models/get_best_teachers_model.dart';
import 'package:meta/meta.dart';

import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/entities/get_best_teachers_entity.dart';
import '../../../domain/usecases/get_best_teacher_usecase.dart';

part 'get_best_teachers_event.dart';
part 'get_best_teachers_state.dart';

class GetBestTeachersBloc extends Bloc<GetBestTeachersEvent, GetBestTeachersState> {
  final GetBestTeachersUseCase getBestTeachersUseCase;
  GetBestTeachersBloc({required this.getBestTeachersUseCase}) : super(GetBestTeachersInitialState()){
    on<GetBestTeachersEvent>((event, emit) async{
      if (event is GetBestTeacher) {
        emit(GetBestTeachersLoadingState());
        final failureOrRequest = await getBestTeachersUseCase();
        failureOrRequest.fold(
                (failure) =>
                emit(GetBestTeacherErrorState(message: mapFailureToMessage(failure))),
                (bestTeachers) => emit(GetBestTeachersLoadedState(getBestTeachersEntity: bestTeachers)));
      }
    });
  }
}
