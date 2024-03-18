import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/entities/packages_hours_ price_entity.dart';
import '../../../domain/usecases/packages_hours_price_usecase.dart';

part 'packages_hours_price_event.dart';
part 'packages_hours_price_state.dart';

class PackagesHoursPriceBloc extends Bloc<PackagesHoursPriceEvent, PackagesHoursPriceState> {
  final PackagesHoursPriceUseCase packagesHoursPriceUseCase;
  PackagesHoursPriceBloc({required this.packagesHoursPriceUseCase}) : super(PackagesHoursPriceInitial()) {
    on<PackagesHoursPriceEvent>((event, emit) async{
      if(event is GetPackagesHoursPrice)
        {
          emit(PackagesHoursPriceLoadingState());
          final failureOrRequest=await packagesHoursPriceUseCase();
          failureOrRequest.fold(
                  (failure) =>
                  emit(PackagesHoursPriceErrorState(message: mapFailureToMessage(failure))),
                  (packages) => emit(PackagesHoursPriceLoadedState(packagesHoursPriceEntity: packages)));
        }
    });
  }
}
