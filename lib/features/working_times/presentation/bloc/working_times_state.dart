part of 'working_times_bloc.dart';
@immutable
abstract class WorkingTimesState {}
class WorkingTimeInitial extends WorkingTimesState{}
class AssignWorkingTimeLoading extends WorkingTimesState{}
class AssignWorkingTimeSucess extends WorkingTimesState{

}
class AssignWorkingTimeFail extends WorkingTimesState{
  final List<String?> message;
  AssignWorkingTimeFail({required this.message});

}

class AddWorkingDayState extends WorkingTimesState{
  List<WorkingDays>days;

  AddWorkingDayState({required this.days});
}
class AddWorkingPeriod extends WorkingTimesState{
  List<WorkingPeriods>periods;

  AddWorkingPeriod({required this.periods});
}
class UpdateDayState extends WorkingTimesState{
  final String day;
  final int index;

  UpdateDayState({required this.day,required this.index});

}
class UpdateBeginningPeriodState extends WorkingTimesState{
  final TimeOfDay beginningPeriod;

  UpdateBeginningPeriodState({required this.beginningPeriod});

}
class UpdateEndPeriodState extends WorkingTimesState{
  final TimeOfDay endPeriod;

  UpdateEndPeriodState({required this.endPeriod});

}
class DeleteDayState extends WorkingTimesState{
  List<WorkingDays> days;

  DeleteDayState({required this.days});
}
class DeletePeriodState extends WorkingTimesState{
  List<WorkingPeriods> periods;

  DeletePeriodState({required this.periods});
}
