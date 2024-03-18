part of 'content_bloc.dart';

@immutable
abstract class ContentEvent {}
class FollowOrUnFollowEvent extends ContentEvent{
  final String teacherId;

  FollowOrUnFollowEvent({required this.teacherId});

}
class GetAllFollowersEvent extends ContentEvent{}
class GetCategoriesQuestionEvent extends ContentEvent{}
class GetCategoriesParagraphEvent extends ContentEvent{}
class GetLevelsContentEvent extends ContentEvent{}
class GetMyLanguageEvent extends ContentEvent{}

class SolveQuestionEvent extends ContentEvent{
  final String questionId;
  final String answerId;
  SolveQuestionEvent({required this.questionId,required this.answerId});
}
