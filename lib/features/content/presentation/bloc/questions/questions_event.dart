part of 'questions_bloc.dart';

@immutable
abstract class QuestionsEvent {}
class DeleteQuestionEvent extends QuestionsEvent{
  final String questionId;
  DeleteQuestionEvent({required this.questionId});
}

class GetQuestionEvent extends QuestionsEvent{
  final String questionId;
  GetQuestionEvent({required this.questionId});
}



class GetAllQuestionsEvent extends QuestionsEvent{
final String pageId;
final String languageId;
final String categoryId;
final String questionLevelId;

  GetAllQuestionsEvent(
      {required this.pageId,required this.languageId,required  this.categoryId,required this.questionLevelId});

}

class GetMyQuestionsEvent extends QuestionsEvent{
  final String pageId;
  final String languageId;
  final String categoryId;
  final String questionLevelId;

  GetMyQuestionsEvent(
      {required this.pageId,required this.languageId,required  this.categoryId,required this.questionLevelId});

}

class CreateQuestionEvent extends QuestionsEvent{
  final QuestionsEntity questionsEntity;
  CreateQuestionEvent({required this.questionsEntity});
}

class UpdateQuestionEvent extends QuestionsEvent{
  final QuestionsEntity questionsEntity;
  UpdateQuestionEvent({required this.questionsEntity});
}

