import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/working_days.dart';

import '../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../data/models/working_times_model.dart';
import '../../domain/entities/working_times_entitiy.dart';
import '../../domain/usecases/assgin_working_time_usecase.dart';
import '../widgets/working_periods.dart';

part 'working_times_event.dart';

part 'working_times_state.dart';

class WorkingTimesBloc extends Bloc<WorkingTimesEvent, WorkingTimesState> {
  List<WorkingDays> workingDays = [];
  final AssignWorkingTimeUseCase assignWorkingTimeUseCase;

  WorkingTimesBloc({required this.assignWorkingTimeUseCase})
      : super(WorkingTimeInitial()) {
    on<WorkingTimesEvent>((event, emit) async {
      if (event is UpdateDayEvent) {
        workingDays[event.index].value = event.day;
        emit(UpdateDayState(day: event.day, index: event.index));
      } else if (event is DeleteDayEvent) {
        workingDays.removeAt(event.indexDay);
        emit(DeleteDayState(days: workingDays));
      } else if (event is DeletePeriodEvent) {
        workingDays[event.indexDay].periods.removeAt(event.indexPeriod);

        // Deep copy the periods list
        List<WorkingPeriods> updatedPeriods = List<WorkingPeriods>.from(
            workingDays[event.indexDay]
                .periods
                .map((period) => period.copyWith()));

        emit(DeletePeriodState(periods: updatedPeriods));
      } else if (event is AddWorkDayEvent) {
        int newIndexDay = workingDays.length;
        event.day.indexDay = newIndexDay;
        workingDays.add(event.day);
        emit(AddWorkingDayState(days: workingDays));
      } else if (event is AddWorkPeriodEvent) {
        int newIndexPeriod = workingDays[event.indexDay].periods.length;
        event.period.indexPeriod = newIndexPeriod;
        workingDays[event.indexDay].periods.add(event.period);
        emit(AddWorkingPeriod(periods: workingDays[event.indexDay].periods));
      } else if (event is UpdateBeginningPeriodEvent) {
        workingDays[event.indexDay].periods[event.indexPeriod].firstTime =
            event.beginningPeriod;
        emit(
            UpdateBeginningPeriodState(beginningPeriod: event.beginningPeriod));
      } else if (event is UpdateEndPeriodEvent) {
        workingDays[event.indexDay].periods[event.indexPeriod].secondTime =
            event.endPeriod;
        emit(UpdateBeginningPeriodState(beginningPeriod: event.endPeriod));
      }
      if (event is AssignWorkingTimeEvent) {
        emit(AssignWorkingTimeLoading());
        final failureOrUnit = await assignWorkingTimeUseCase(
            assignWorkingTimeModel: event.workingTimesModel);
        failureOrUnit.fold(
            (failure) => emit(
                AssignWorkingTimeFail(message: mapFailureToMessage(failure))),
            (r) => emit(AssignWorkingTimeSucess()));
      }
    });
  }
}
