import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learny_project/features/auth/presentation/widgets/map_failure_to_message.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/info_home_entity.dart';
import '../../../domain/usecases/info_usecase.dart';

part 'info_home_event.dart';

part 'info_home_state.dart';

class InfoHomeBloc extends Bloc<InfoHomeEvent, InfoHomeState> {
  final InfoUseCase infoUseCase;

  InfoHomeBloc({required this.infoUseCase}) : super(InfoHomeInitial()) {
    on<InfoHomeEvent>((event, emit) async {
      if (event is InfoHome) {
        emit(InfoHomeLoading());
        final failureOrRequest = await infoUseCase();
        failureOrRequest.fold(
            (failure) =>
                emit(InfoHomeError(message: mapFailureToMessage(failure))),
            (info) => emit(InfoHomeLoaded(infoHomeEntity: info)));
      }
    });
  }
}
