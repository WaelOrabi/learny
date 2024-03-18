part of 'paragraphs_bloc.dart';

@immutable
abstract class ParagraphsEvent {}
class DeleteParagraphEvent extends ParagraphsEvent{
  final String paragraphId;
  DeleteParagraphEvent({required this.paragraphId});
}

class GetParagraphEvent extends ParagraphsEvent{
  final String paragraphId;
  GetParagraphEvent({required this.paragraphId});
}


class GetAllParagraphsEvent extends ParagraphsEvent{
  final String pageId;
  final String languageId;
  final String categoryId;
  final String paragraphLevelId;

  GetAllParagraphsEvent(
      {required this.pageId,required this.languageId,required  this.categoryId,required this.paragraphLevelId});

}

class GetMyParagraphsEvent extends ParagraphsEvent{
  final String pageId;
  final String languageId;
  final String categoryId;
  final String paragraphLevelId;

  GetMyParagraphsEvent(
      {required this.pageId,required this.languageId,required  this.categoryId,required this.paragraphLevelId});

}

class CreateParagraphEvent extends ParagraphsEvent{
  final ParagraphsEntity paragraphsEntity;
  CreateParagraphEvent({required this.paragraphsEntity});
}

class UpdateParagraphEvent extends ParagraphsEvent{
  final ParagraphsEntity paragraphsEntity;
  UpdateParagraphEvent({required this.paragraphsEntity});
}
