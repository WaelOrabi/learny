part of 'language_bloc.dart';

@immutable
abstract class LanguageState extends Equatable{
  @override
  List<Object> get props=>[];
}


class LanguageInitial extends LanguageState {}


class GetAllLanguagesLoadingState extends LanguageState {}

class GetAllLanguagesSuccessState extends LanguageState {
  final List<Language> listAllLanguages;

  GetAllLanguagesSuccessState({required this.listAllLanguages});
}

class GetAllLanguagesErrorState extends LanguageState {
  final List<String> message;

  GetAllLanguagesErrorState({required this.message});
  @override
  List<Object>get props=>[message];
}


class AddLanguageLoadingState extends LanguageState {}

class AddLanguageSuccessState extends LanguageState {}

class AddLanguageErrorState extends LanguageState {
  final List<String> message;

  AddLanguageErrorState({required this.message});
  @override
  List<Object>get props=>[message];
}




class DeleteLanguageLoadingState extends LanguageState {}

class DeleteLanguageSuccessState extends LanguageState {}

class DeleteLanguageErrorState extends LanguageState {
  final List<String> message;

  DeleteLanguageErrorState({required this.message});
  @override
  List<Object>get props=>[message];
}
