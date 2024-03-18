part of 'delete_appointment_bloc.dart';

abstract class DeleteAppointmentState  {
  const DeleteAppointmentState();
}

class DeleteAppointmentInitial extends DeleteAppointmentState {}
class DeleteAppointmentLoading extends DeleteAppointmentState{}
class DeleteAppointmentLoaded extends DeleteAppointmentState{}
class DeleteAppointmentError extends DeleteAppointmentState{
  final List<String>message;

  DeleteAppointmentError({required this.message});

}
