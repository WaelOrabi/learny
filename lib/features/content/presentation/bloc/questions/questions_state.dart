part of 'questions_bloc.dart';

@immutable
abstract class QuestionsState {}

class QuestionsInitial extends QuestionsState {}


class DeleteQuestionLoading extends QuestionsState{}
class DeleteQuestionError extends QuestionsState{
  List<String>message;
  DeleteQuestionError({required this.message});
}
class DeleteQuestionSuccess extends QuestionsState{}




class GetQuestionLoading extends QuestionsState{}
class GetQuestionError extends QuestionsState{
  List<String>message;
  GetQuestionError({required this.message});
}
class GetQuestionSuccess extends QuestionsState{
  final QuestionsEntity questionsEntity;
  GetQuestionSuccess({required this.questionsEntity});
}




class SolveQuestionLoading extends QuestionsState{}
class SolveQuestionError extends QuestionsState{
  List<String>message;
  SolveQuestionError({required this.message});
}
class SolveQuestionSuccess extends QuestionsState{}




class GetAllQuestionsLoading extends QuestionsState{}
class GetAllQuestionsError extends QuestionsState{
  List<String>message;
  GetAllQuestionsError({required this.message});
}
class GetAllQuestionsSuccess extends QuestionsState{
  final AllQuestionsEntity listQuestions;
  GetAllQuestionsSuccess({required this.listQuestions});
}




class GetMyQuestionsLoading extends QuestionsState{}
class GetMyQuestionsError extends QuestionsState{
  List<String>message;
  GetMyQuestionsError({required this.message});
}
class GetMyQuestionsSuccess extends QuestionsState{
  final AllQuestionsEntity listQuestions;
  GetMyQuestionsSuccess({required this.listQuestions});
}



class CreateQuestionLoading extends QuestionsState{}
class CreateQuestionError extends QuestionsState{
  List<String>message;
  CreateQuestionError({required this.message});
}
class CreateQuestionSuccess extends QuestionsState{}




class UpdateQuestionLoading extends QuestionsState{}
class UpdateQuestionError extends QuestionsState{
  List<String>message;
  UpdateQuestionError({required this.message});
}
class UpdateQuestionSuccess extends QuestionsState{}


