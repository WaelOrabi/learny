import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learny_project/features/content/domain/entities/all_questions_entity.dart';
import 'package:learny_project/features/content/domain/entities/questions_entity.dart';
import 'package:learny_project/features/content/domain/usecases/questions/update_question_use_case.dart';
import 'package:meta/meta.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../admin/domain/entities/language_entity.dart';
import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/entities/category_question.dart';
import '../../../domain/entities/level_content.dart';
import '../../../domain/usecases/questions/create_question_use_case.dart';
import '../../../domain/usecases/questions/delete_question_use_case.dart';
import '../../../domain/usecases/questions/get_all_questions_use_case.dart';
import '../../../domain/usecases/questions/get_my_questions_use_case.dart';
import '../../../domain/usecases/questions/get_question_use_case.dart';
import '../../../domain/usecases/questions/solve_question_use_case.dart';

part 'questions_event.dart';

part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {


  final CreateQuestionUseCase createQuestionUseCase;
  final DeleteQuestionUseCase deleteQuestionUseCase;
  final GetAllQuestionsUseCase getAllQuestionsUseCase;
  final GetMyQuestionsUseCase getMyQuestionsUseCase;
  final GetQuestionUseCase getQuestionUseCase;

  final UpdateQuestionUseCase updateQuestionUseCase;

  QuestionsBloc(
      {required this.createQuestionUseCase, required this.deleteQuestionUseCase, required this.getAllQuestionsUseCase, required this.getMyQuestionsUseCase, required this.getQuestionUseCase, required this.updateQuestionUseCase})
      : super(QuestionsInitial()) {
    on<QuestionsEvent>((event, emit) async {
if(event is DeleteQuestionEvent){
  emit(DeleteQuestionLoading());
  final failureOrRequest = await deleteQuestionUseCase(questionId: event.questionId);
  failureOrRequest.fold((failure) {
    emit(DeleteQuestionError(message: mapFailureToMessage(failure)));
  }, (message) {
    emit(DeleteQuestionSuccess());
  });
}else if(event is GetQuestionEvent){
  emit(GetQuestionLoading());
  final failureOrRequest = await getQuestionUseCase(questionId: event.questionId);
  failureOrRequest.fold((failure) {
    emit(GetQuestionError(message: mapFailureToMessage(failure)));
  }, (message) {
    emit(GetQuestionSuccess(questionsEntity: message));
  });
}else if(event is GetAllQuestionsEvent){
  emit(GetAllQuestionsLoading());
  final failureOrRequest = await getAllQuestionsUseCase(categoryId: event.categoryId,languageId: event.languageId,pageId: event.pageId,questionLevelId: event.questionLevelId);
  failureOrRequest.fold((failure) {
    emit(GetAllQuestionsError(message: mapFailureToMessage(failure)));
  }, (message) {
    emit(GetAllQuestionsSuccess(listQuestions:message));
  });
}else if(event is GetMyQuestionsEvent){
  emit(GetMyQuestionsLoading());
  final failureOrRequest = await getMyQuestionsUseCase(categoryId: event.categoryId,languageId: event.languageId,pageId: event.pageId,questionLevelId: event.questionLevelId);
  failureOrRequest.fold((failure) {
    emit(GetMyQuestionsError(message: mapFailureToMessage(failure)));
  }, (message) {
    emit(GetMyQuestionsSuccess(listQuestions:message));
  });
}else if(event is CreateQuestionEvent){
  emit(CreateQuestionLoading());
  final failureOrRequest = await createQuestionUseCase(questionsEntity: event.questionsEntity);
  failureOrRequest.fold((failure) {
    emit(CreateQuestionError(message: mapFailureToMessage(failure)));
  }, (message) {
    emit(CreateQuestionSuccess());
  });
}
else if(event is UpdateQuestionEvent){
  emit(UpdateQuestionLoading());
  final failureOrRequest = await updateQuestionUseCase(questionsEntity: event.questionsEntity);
  failureOrRequest.fold((failure) {
    emit(UpdateQuestionError(message: mapFailureToMessage(failure)));
  }, (message) {
    emit(UpdateQuestionSuccess());
  });
}

    });
  }
}


