
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:learny_project/core/error/failure.dart';
import 'package:learny_project/features/teachers/domain/entities/teachers_entity.dart';
import 'package:meta/meta.dart';

import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/usecases/get_teachers_usecase.dart';

part 'get_teachers_event.dart';

part 'get_teachers_state.dart';

class GetTeachersBloc extends Bloc<GetTeachersEvent, GetTeachersState> {
  final GetTeachersUseCase getTeachersUseCase;
int pageNum=1;
  GetTeachersBloc({required this.getTeachersUseCase})
      : super(GetTeachersInitialState()) {
    on<GetTeachersEvent>((event, emit) async {
      if (event is GetTeachers) {
        emit(GetTeachersLoadingState());
        final Either<Failure, TeachersEntity> failureOrRequest =
            await getTeachersUseCase(
                languages: event.languages, numberPage: event.page);
        failureOrRequest.fold(
            (failure) => emit(GetTeachersErrorState(
                  message: mapFailureToMessage(failure),
                )),
            (teachers) => emit(
                  GetTeachersSuccessState(teachers: teachers),
                ));
      }
    });
  }
}
