import 'package:equatable/equatable.dart';
import 'package:learny_project/features/content/domain/entities/questions_entity.dart';

class AllQuestionsEntity extends Equatable{

  final PagesPage pages;
  final List<QuestionsEntity> questionsEntity;

  AllQuestionsEntity({required this.pages,required this.questionsEntity});

  @override
  // TODO: implement props
  List<Object?> get props =>[pages,questionsEntity];

}