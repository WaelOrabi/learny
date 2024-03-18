import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/usecases/certificate_types_usecase/add_certificate_type_usecase.dart';
import '../../../domain/usecases/certificate_types_usecase/delete_certificate_type_usecase.dart';
import '../../../domain/usecases/certificate_types_usecase/get_all_certificate_types_usecase.dart';
import 'package:meta/meta.dart';

import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/entities/certificate_type_entity.dart';

part 'certificate_type_event.dart';
part 'certificate_type_state.dart';

class CertificateTypeBloc extends Bloc<CertificateTypeEvent, CertificateTypeState> {
  final  AddCertificateTypeUseCase addCertificateTypeUseCase;
  final GetAllCertificateTypesUseCase getAllCertificateTypesUseCase;
  final DeleteCertificateTypeUseCase deleteCertificateTypeUseCase;
  List<CertificateType> listCertificateType=[CertificateType(certificateTypeId: "1", certificateTypeName: "Master's")];
  CertificateTypeBloc(
      {required this.addCertificateTypeUseCase,
     required this.getAllCertificateTypesUseCase,
     required this.deleteCertificateTypeUseCase}) : super(CertificateTypeInitial()) {
    on<CertificateTypeEvent>((event, emit) {
      if (event is GetAllCertificateTypesEvent) {
        gitAllCertificateTypes();
      } else if (event is AddCertificateTypeEvent) {
        addCertificateType(certificateTypeName: event.certificateTypeName);
      } else if (event is DeleteCertificateTypeEvent) {
        deleteCertificateType(certificateTypeId: event.certificateTypeId);
      }
    });
  }

  Future<void> gitAllCertificateTypes() async {
    emit(GetAllCertificateTypesLoadingState());
    final failureOrCertificateTypes = await getAllCertificateTypesUseCase();
    failureOrCertificateTypes.fold((failure) {
      emit(GetAllCertificateTypesErrorState(message: mapFailureToMessage(failure)));
    }, (certificateTypes) {
      listCertificateType=certificateTypes;
      emit(GetAllCertificateTypesSuccessState(listAllCertificateTypes: certificateTypes));
    });
  }

  Future<void> addCertificateType({required String certificateTypeName}) async {
    emit(AddCertificateTypeLoadingState());
    final failureOrCertificateTypes =
    await addCertificateTypeUseCase(certificateTypeName: certificateTypeName);
    failureOrCertificateTypes.fold((failure) {
      emit(AddCertificateTypeErrorState(message: mapFailureToMessage(failure)));
    }, (certificateTypes) {
      emit(AddCertificateTypeSuccessState());
    });
  }

  Future<void> deleteCertificateType({required String certificateTypeId}) async {
    emit(DeleteCertificateTypeLoadingState());
    final failureOrCertificateTypes = await deleteCertificateTypeUseCase(certificateTypeId: certificateTypeId);
    failureOrCertificateTypes.fold((failure) {
      emit(DeleteCertificateTypeErrorState(message: mapFailureToMessage(failure)));
    }, (certificateTypes) {
      emit(DeleteCertificateTypeSuccessState());
    });
  }



}
