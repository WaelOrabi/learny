import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learny_project/features/home/domain/entities/services_entity.dart';
import 'package:meta/meta.dart';

import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/usecases/services_usecase.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final ServicesUseCase servicesUseCase;
  ServicesBloc({required this.servicesUseCase}) : super(ServicesInitial()) {
    on<ServicesEvent>((event, emit)async {
        if (event is GetServices) {
          emit(ServicesLoadingState());
          final failureOrRequest = await servicesUseCase();
          failureOrRequest.fold(
                  (failure) =>
                  emit(ServicesErrorState(message: mapFailureToMessage(failure))),
                  (services) => emit(ServicesLoadedState(services: services)));
        }
    });
  }
}
