import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/entities/donor_type_entity.dart';
import '../../../domain/usecases/donor_types_usecase/add_donor_type_usecase.dart';
import '../../../domain/usecases/donor_types_usecase/delete_donor_type_usecase.dart';
import '../../../domain/usecases/donor_types_usecase/get_all_donor_types_usecase.dart';

part 'donor_type_event.dart';
part 'donor_type_state.dart';

class DonorTypeBloc extends Bloc<DonorTypeEvent, DonorTypeState> {
  final AddDonorTypeUseCase addDonorTypeUseCase;
  final GetAllDonorTypesUseCase getAllDonorTypesUseCase;
  final DeleteDonorTypeUseCase deleteDonorTypeUseCase;
  List<DonorType> listDonorType=[DonorType(donorTypeId: "1", donorTypeName: "Academic education")];
  DonorTypeBloc(
      {required this.addDonorTypeUseCase,
     required this.getAllDonorTypesUseCase,
     required this.deleteDonorTypeUseCase}) : super(DonorTypeInitial()) {
    on<DonorTypeEvent>((event, emit) {
      if (event is GetAllDonorTypesEvent) {
        gitAllDonorTypes();
      } else if (event is AddDonorTypeEvent) {
        addDonorType(donorTypeName: event.donorTypeName);
      } else if (event is DeleteDonorTypeEvent) {
        deleteDonorType(donorTypeId: event.donorTypeId);
      }
    });
  }

  Future<void> gitAllDonorTypes() async {
    emit(GetAllDonorTypesLoadingState());
    final failureOrDonorTypes = await getAllDonorTypesUseCase();
    failureOrDonorTypes.fold((failure) {
      emit(GetAllDonorTypesErrorState(message: mapFailureToMessage(failure)));
    }, (donorTypes) {
      listDonorType=donorTypes;
      emit(GetAllDonorTypesSuccessState(listAllDonorTypes: donorTypes));
    });
  }

  Future<void> addDonorType({required String donorTypeName}) async {
    emit(AddDonorTypeLoadingState());
    final failureOrDonorTypes =
    await addDonorTypeUseCase(donorTypeName: donorTypeName);
    failureOrDonorTypes.fold((failure) {
      emit(AddDonorTypeErrorState(message: mapFailureToMessage(failure)));
    }, (donorTypes) {
      emit(AddDonorTypeSuccessState());
    });
  }

  Future<void> deleteDonorType({required String donorTypeId}) async {
    emit(DeleteDonorTypeLoadingState());
    final failureOrDonorTypes = await deleteDonorTypeUseCase(donorTypeId: donorTypeId);
    failureOrDonorTypes.fold((failure) {
      emit(DeleteDonorTypeErrorState(message: mapFailureToMessage(failure)));
    }, (donorTypes) {
      emit(DeleteDonorTypeSuccessState());
    });
  }

}
