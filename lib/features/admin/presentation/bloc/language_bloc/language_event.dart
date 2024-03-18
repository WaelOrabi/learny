part of 'language_bloc.dart';

@immutable
abstract class LanguageEvent extends Equatable{
  @override
  List<Object> get props=>[];
}


class GetAllLanguagesEvent extends LanguageEvent{}


class AddLanguageEvent extends LanguageEvent{
  final String languageName;

  AddLanguageEvent({required this.languageName});
  @override
  List<Object> get props=>[languageName];

}

class DeleteLanguageEvent extends LanguageEvent{
  final String languageId;

  DeleteLanguageEvent({required this.languageId});
  @override
  List<Object> get props=>[languageId];

}