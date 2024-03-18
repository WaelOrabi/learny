
import 'package:equatable/equatable.dart';

class OptionsQuestionEntity extends Equatable
{
  String optionId;
  String optionName;
  bool isTrue;

  OptionsQuestionEntity({required this.optionId,required this.optionName,required this.isTrue});
  @override
  // TODO: implement props
  List<Object?> get props => [optionId,optionName];

}