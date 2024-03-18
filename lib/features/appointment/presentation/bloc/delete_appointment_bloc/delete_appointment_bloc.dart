import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/usecases/delete_booking_appointment_usecase.dart';
part 'delete_appointment_event.dart';

part 'delete_appointment_state.dart';

class DeleteAppointmentBloc
    extends Bloc<DeleteAppointmentEvent, DeleteAppointmentState> {
  final DeleteBookingAppointmentUseCase deleteBookingAppointmentUseCase;

  DeleteAppointmentBloc({required this.deleteBookingAppointmentUseCase})
      : super(DeleteAppointmentInitial()) {
    on<DeleteAppointmentEvent>((event, emit) async {
      if (event is DeleteAppointment) {
        emit(DeleteAppointmentLoading());
        final Either<Failure, Unit> failureOrRequest =
            await deleteBookingAppointmentUseCase(
                idAppointment: event.idAppointment);
        failureOrRequest.fold(
          (failure) => emit(DeleteAppointmentError(
            message: mapFailureToMessage(failure),
          )),
          (r) => emit(DeleteAppointmentLoaded()),
        );
      }
    });
  }
}
