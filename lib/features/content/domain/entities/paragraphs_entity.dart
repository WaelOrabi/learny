import 'package:equatable/equatable.dart';
import 'package:learny_project/features/admin/domain/entities/language_entity.dart';
import 'package:learny_project/features/content/domain/entities/category_paragraph.dart';
import 'package:learny_project/features/content/domain/entities/category_question.dart';
import 'package:learny_project/features/content/domain/entities/level_content.dart';
import 'options_question_entity.dart';


class ParagraphsEntity extends Equatable {
  String teacherId;
  String firstNameTeacher;
  String lastNameTeacher;
  Language languageParagraph;
  String? profileImageTeacher;
  bool isFollowingTeacher;
  LevelContentEntity level;
  String paragraphId;
  String paragraphName;
  CategoryParagraphEntity categoryParagraph;
  ParagraphsEntity(
      {required this.teacherId,
        required this.firstNameTeacher,
        required this.lastNameTeacher,
        required this.languageParagraph,
        this.profileImageTeacher,
        required this.isFollowingTeacher,
        required this.level,
        required this.paragraphId,
        required this.paragraphName,
        required this.categoryParagraph,
      });

  @override
  List<Object?> get props => [
    teacherId,
    firstNameTeacher,
    lastNameTeacher,
    profileImageTeacher,
    languageParagraph,
    isFollowingTeacher,
    level,
    paragraphId,
    paragraphName,
    categoryParagraph
  ];
}
