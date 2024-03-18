part of 'accept_or_reject_appointment_bloc.dart';

@immutable
abstract class AcceptOrRejectAppointmentState {}

class AcceptOrRejectAppointmentInitial extends AcceptOrRejectAppointmentState {}

class AcceptRequestLoadingState extends AcceptOrRejectAppointmentState{}
class RejectRequestLoadingState extends AcceptOrRejectAppointmentState{}
class AcceptAppointmentState extends AcceptOrRejectAppointmentState{

}
class RejectAppointmentState extends AcceptOrRejectAppointmentState{

}
class AcceptOrRejectAppointmentErrorState extends AcceptOrRejectAppointmentState{
  List<String>message;
  AcceptOrRejectAppointmentErrorState({required this.message});
}