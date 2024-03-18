import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learny_project/features/content/data/models/all_paragraphs_model.dart';
import 'package:learny_project/features/content/domain/entities/all_paragraphs_entity.dart';
import 'package:learny_project/features/content/presentation/pages/paragraphs/stories_paragraphs.dart';
import 'package:meta/meta.dart';

import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/entities/paragraphs_entity.dart';
import '../../../domain/entities/paragraphs_entity.dart';
import '../../../domain/usecases/paragraphs/create_paragraph_use_case.dart';
import '../../../domain/usecases/paragraphs/delete_paragraph_use_case.dart';
import '../../../domain/usecases/paragraphs/get_all_paragraphs_use_case.dart';
import '../../../domain/usecases/paragraphs/get_my_paragraphs_use_case.dart';
import '../../../domain/usecases/paragraphs/get_paragraph_use_case.dart';
import '../../../domain/usecases/paragraphs/update_paragraph_use_case.dart';

part 'paragraphs_event.dart';
part 'paragraphs_state.dart';

class ParagraphsBloc extends Bloc<ParagraphsEvent, ParagraphsState> {

  HelpParagraph helpParagraph=HelpParagraph(0, false);

  final CreateParagraphUseCase createParagraphUseCase;
  final DeleteParagraphUseCase deleteParagraphUseCase;
  final GetAllParagraphsUseCase getAllParagraphsUseCase;
  final GetMyParagraphsUseCase getMyParagraphsUseCase;
  final GetParagraphUseCase getParagraphUseCase;
  final UpdateParagraphUseCase updateParagraphUseCase;
  ParagraphsBloc(
      {required this.createParagraphUseCase,
     required this.deleteParagraphUseCase,
     required this.getAllParagraphsUseCase,
     required this.getMyParagraphsUseCase,
     required this.getParagraphUseCase,
     required this.updateParagraphUseCase}) : super(ParagraphsInitial()) {
    on<ParagraphsEvent>((event, emit) async{
if(event is DeleteParagraphEvent){
  emit(DeleteParagraphLoading());
  final failureOrRequest = await deleteParagraphUseCase(paragraphId: event.paragraphId);
  failureOrRequest.fold((failure) {
    emit(DeleteParagraphError(message: mapFailureToMessage(failure)));
  }, (message) {
    emit(DeleteParagraphSuccess());
  });
}else if(event is GetParagraphEvent){
  emit(GetParagraphLoading());
  final failureOrRequest = await getParagraphUseCase(paragraphId: event.paragraphId);
  failureOrRequest.fold((failure) {
    emit(GetParagraphError(message: mapFailureToMessage(failure)));
  }, (message) {
    emit(GetParagraphSuccess(paragraphsEntity:message));
  });
}else if(event is GetAllParagraphsEvent){
  emit(GetAllParagraphsLoading());
  final failureOrRequest = await getAllParagraphsUseCase(categoryId: event.categoryId,languageId: event.languageId,pageId: event.pageId,paragraphLevelId: event.paragraphLevelId);
  failureOrRequest.fold((failure) {
    emit(GetAllParagraphsError(message: mapFailureToMessage(failure)));
  }, (message) {
    emit(GetAllParagraphsSuccess(listParagraphs:message));
  });
}else if(event is GetMyParagraphsEvent){
  emit(GetMyParagraphsLoading());
  final failureOrRequest = await getMyParagraphsUseCase(categoryId: event.categoryId,languageId: event.languageId,pageId: event.pageId,paragraphLevelId: event.paragraphLevelId);
  failureOrRequest.fold((failure) {
    emit(GetMyParagraphsError(message: mapFailureToMessage(failure)));
  }, (message) {
    emit(GetMyParagraphsSuccess(listParagraphs:message));
  });
}else if(event is CreateParagraphEvent){
  emit(CreateParagraphLoading());
  final failureOrRequest = await createParagraphUseCase(paragraphsEntity: event.paragraphsEntity);
  failureOrRequest.fold((failure) {
    emit(CreateParagraphError(message: mapFailureToMessage(failure)));
  }, (message) {
    emit(CreateParagraphSuccess());
  });
}else if(event is UpdateParagraphEvent){
  emit(UpdateParagraphLoading());
  final failureOrRequest = await updateParagraphUseCase(paragraphsEntity: event.paragraphsEntity);
  failureOrRequest.fold((failure) {
    emit(UpdateParagraphError(message: mapFailureToMessage(failure)));
  }, (message) {
    emit(UpdateParagraphSuccess());
  });
}
    });
  }
}
