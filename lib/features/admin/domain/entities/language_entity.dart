import 'package:equatable/equatable.dart';

class Language extends Equatable{
  String languageId;
  String languageName;
  Language({required this.languageId,required this.languageName});

  @override
  List<Object?> get props => [languageId,languageName];

}