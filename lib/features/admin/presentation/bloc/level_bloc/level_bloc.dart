import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../auth/presentation/widgets/map_failure_to_message.dart';

import '../../../domain/entities/level_entity.dart';
import '../../../domain/usecases/levels_usecase/add_level_usecase.dart';
import '../../../domain/usecases/levels_usecase/delete_level_usecase.dart';
import '../../../domain/usecases/levels_usecase/get_all_levels_usecase.dart';

part 'level_event.dart';
part 'level_state.dart';

class LevelBloc extends Bloc<LevelEvent, LevelState> {
  final AddLevelUseCase addLevelUseCase;
  final GetAllLevelsUseCase getAllLevelsUseCase;
  final DeleteLevelUseCase deleteLevelUseCase;
List<Level> listLevels=[Level(levelId: "1", levelName: "A1", levelDescription: "")];
  LevelBloc({required this.addLevelUseCase,
    required this.getAllLevelsUseCase,
    required this.deleteLevelUseCase}) : super(LevelInitial()) {
    on<LevelEvent>((event, emit) {
      if (event is GetAllLevelsEvent) {
        gitAllLevels();
      } else if (event is AddLevelEvent) {
        addLevel(levelName: event.levelName,
            levelDescription: event.levelDescription);
      } else if (event is DeleteLevelEvent) {
        deleteLevel(levelId: event.levelId);
      }
    });
  }

  Future<void> gitAllLevels() async {
    emit(GetAllLevelsLoadingState());
    final failureOrLevels = await getAllLevelsUseCase();
    failureOrLevels.fold((failure) {
      emit(GetAllLevelsErrorState(message: mapFailureToMessage(failure)));
    }, (levels) {
      listLevels=levels;
      emit(GetAllLevelsSuccessState(listAllLevels: levels));
    });
  }

  Future<void> addLevel(
      {required String levelName, required String levelDescription}) async {
    emit(AddLevelLoadingState());
    final failureOrLevels =
    await addLevelUseCase(
        levelName: levelName, levelDescription: levelDescription);
    failureOrLevels.fold((failure) {
      emit(AddLevelErrorState(message: mapFailureToMessage(failure)));
    }, (levels) {
      emit(AddLevelSuccessState());
    });
  }

  Future<void> deleteLevel({required String levelId}) async {
    emit(DeleteLevelLoadingState());
    final failureOrLevels = await deleteLevelUseCase(levelId: levelId);
    failureOrLevels.fold((failure) {
      emit(DeleteLevelErrorState(message: mapFailureToMessage(failure)));
    }, (levels) {
      emit(DeleteLevelSuccessState());
    });
  }
}