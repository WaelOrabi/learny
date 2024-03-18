import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learny_project/features/auth/presentation/widgets/map_failure_to_message.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/get_goals_entity.dart';
import '../../../domain/usecases/get_goals_usecase.dart';

part 'get_goals_event.dart';

part 'get_goals_state.dart';

class GetGoalsBloc extends Bloc<GetGoalsEvent, GetGoalsState> {
  final GetGoalsUseCase getGoalsUseCase;

  GetGoalsBloc({required this.getGoalsUseCase}) : super(GetGoalsInitial()) {
    on<GetGoalsEvent>((event, emit) async {
      if (event is GetAllGoals) {
        emit(GetAllGoalsLoading());
        final failureOrRequest = await getGoalsUseCase();
        failureOrRequest.fold((failure) =>
            emit(GetAllGoalsError(message: mapFailureToMessage(failure))), (
            goals) => emit(GetAllGoalsState(goalsEntity: goals)));
      }
    });
  }
}
