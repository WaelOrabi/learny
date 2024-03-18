part of 'paragraphs_bloc.dart';

@immutable
abstract class ParagraphsState {}

class ParagraphsInitial extends ParagraphsState {}


class DeleteParagraphLoading extends ParagraphsState{}
class DeleteParagraphError extends ParagraphsState{
  List<String>message;
  DeleteParagraphError({required this.message});
}
class DeleteParagraphSuccess extends ParagraphsState{}




class GetParagraphLoading extends ParagraphsState{}
class GetParagraphError extends ParagraphsState{
  List<String>message;
  GetParagraphError({required this.message});
}
class GetParagraphSuccess extends ParagraphsState{
  final ParagraphsEntity paragraphsEntity;
  GetParagraphSuccess({required this.paragraphsEntity});
}


class GetAllParagraphsLoading extends ParagraphsState{}
class GetAllParagraphsError extends ParagraphsState{
  List<String>message;
  GetAllParagraphsError({required this.message});
}
class GetAllParagraphsSuccess extends ParagraphsState{
  final AllParagraphsEntity listParagraphs;
  GetAllParagraphsSuccess({required this.listParagraphs});
}




class GetMyParagraphsLoading extends ParagraphsState{}
class GetMyParagraphsError extends ParagraphsState{
  List<String>message;
  GetMyParagraphsError({required this.message});
}
class GetMyParagraphsSuccess extends ParagraphsState{
  final AllParagraphsEntity listParagraphs;
  GetMyParagraphsSuccess({required this.listParagraphs});
}



class CreateParagraphLoading extends ParagraphsState{}
class CreateParagraphError extends ParagraphsState{
  List<String>message;
  CreateParagraphError({required this.message});
}
class CreateParagraphSuccess extends ParagraphsState{}




class UpdateParagraphLoading extends ParagraphsState{}
class UpdateParagraphError extends ParagraphsState{
  List<String>message;
  UpdateParagraphError({required this.message});
}
class UpdateParagraphSuccess extends ParagraphsState{}


