part of 'content_bloc.dart';

@immutable
abstract class ContentState {}

class ContentInitial extends ContentState {}

class FollowOrUnFollowLoadingState extends ContentState{}
class FollowOrUnFollowErrorState extends ContentState{
  List<String>message;
  FollowOrUnFollowErrorState({required this.message});
}
class FollowOrUnFollowSuccessState extends ContentState{}



class GetAllFollowersLoadingState extends ContentState{}
class GetAllFollowersErrorState extends ContentState{
  List<String>message;
  GetAllFollowersErrorState({required this.message});
}
class GetAllFollowersSuccessState extends ContentState{
  final TeachersEntity teachersEntity;
  GetAllFollowersSuccessState({required this.teachersEntity});
}



class GetCategoriesQuestionLoading extends ContentState{}
class GetCategoriesQuestionError extends ContentState{
  List<String>message;
  GetCategoriesQuestionError({required this.message});
}
class GetCategoriesQuestionSuccess extends ContentState{
  final List<CategoryQuestionEntity> listCategoryQuestionEntity;
  GetCategoriesQuestionSuccess({required this.listCategoryQuestionEntity});
}


class GetCategoriesParagraphLoading extends ContentState{}
class GetCategoriesParagraphError extends ContentState{
  List<String>message;
  GetCategoriesParagraphError({required this.message});
}
class GetCategoriesParagraphSuccess extends ContentState{
  final List<CategoryParagraphEntity> listCategoryParagraphEntity;
  GetCategoriesParagraphSuccess({required this.listCategoryParagraphEntity});
}



class GetLevelsContentLoading extends ContentState{}
class GetLevelsContentError extends ContentState{
  List<String>message;
  GetLevelsContentError({required this.message});
}
class GetLevelsContentSuccess extends ContentState{
  final List<LevelContentEntity> listLevelContentEntity;
  GetLevelsContentSuccess({required this.listLevelContentEntity});
}



class SolveQuestionLoading extends ContentState{}
class SolveQuestionError extends ContentState{
  List<String>message;
  SolveQuestionError({required this.message});
}
class SolveQuestionSuccess extends ContentState{}



class GetMyLanguagesLoading extends ContentState{}
class GetMyLanguagesError extends ContentState{
  List<String>message;
  GetMyLanguagesError({required this.message});
}
class GetMyLanguagesSuccess extends ContentState{
  final List<Language> listLanguages;
  GetMyLanguagesSuccess({required this.listLanguages});
}

