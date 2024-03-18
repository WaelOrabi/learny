import 'package:equatable/equatable.dart';
import 'package:learny_project/features/content/domain/entities/paragraphs_entity.dart';
import 'package:learny_project/features/content/domain/entities/questions_entity.dart';

class AllParagraphsEntity extends Equatable{

  final PagesPage pages;
  final List<ParagraphsEntity> paragraphsEntity;

  AllParagraphsEntity({required this.pages,required this.paragraphsEntity});

  @override
  // TODO: implement props
  List<Object?> get props =>[pages,paragraphsEntity];

}