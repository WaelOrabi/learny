part of 'working_times_bloc.dart';
@immutable
abstract class WorkingTimesEvent {}
class UpdateDayEvent extends WorkingTimesEvent{
  final String day;
  final int index;

  UpdateDayEvent({required this.day,required this.index});

}
class AddWorkDayEvent extends WorkingTimesEvent{
  WorkingDays day;

  AddWorkDayEvent({required this.day});
}
class AddWorkPeriodEvent extends WorkingTimesEvent{
  final WorkingPeriods period;
  final int indexDay;
  AddWorkPeriodEvent({required this.period,required this.indexDay});
}

class UpdateBeginningPeriodEvent extends WorkingTimesEvent{
  final TimeOfDay beginningPeriod ;
  final int indexDay;
  final int indexPeriod;

  UpdateBeginningPeriodEvent({required this.beginningPeriod,required this.indexDay,required this.indexPeriod});

}
class UpdateEndPeriodEvent extends WorkingTimesEvent{
  final TimeOfDay endPeriod;
  final int indexDay;
  final int indexPeriod;
  UpdateEndPeriodEvent({required this.endPeriod,required this.indexPeriod,required this.indexDay});

}

class DeleteDayEvent extends WorkingTimesEvent{
  final int indexDay;

  DeleteDayEvent({required this.indexDay});

}
class DeletePeriodEvent extends WorkingTimesEvent{
  final int indexPeriod;
  final int indexDay;

  DeletePeriodEvent({required this.indexPeriod,required this.indexDay});

}

class AssignWorkingTimeEvent extends WorkingTimesEvent{
  final AssignWorkingTimeModel workingTimesModel;

  AssignWorkingTimeEvent({required this.workingTimesModel});
}
