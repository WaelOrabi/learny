import 'package:equatable/equatable.dart';
import 'package:learny_project/features/admin/domain/entities/language_entity.dart';
import 'package:learny_project/features/content/domain/entities/level_content.dart';
import 'category_question.dart';
import 'options_question_entity.dart';

class QuestionsEntity extends Equatable {
  String teacherId;
  String firstNameTeacher;
  String lastNameTeacher;
  Language languagesTeacher;
  String? profileImageTeacher;
  bool isFollowingTeacher;
  bool isSolve;
  LevelContentEntity level;
  String questionId;
  String questionName;
  String? descriptionAnswer;
  CategoryQuestionEntity categoryQuestion;
  List<OptionsQuestionEntity> optionsList;

  QuestionsEntity({
    required this.teacherId,
    required this.firstNameTeacher,
    required this.lastNameTeacher,
    required this.languagesTeacher,
    this.profileImageTeacher,
    required this.isFollowingTeacher,
    required this.isSolve,
    required this.level,
    required this.questionId,
    required this.questionName,
    required this.categoryQuestion,
    required this.optionsList,
    this.descriptionAnswer,
  });

  @override
  List<Object?> get props => [
        teacherId,
        firstNameTeacher,
        lastNameTeacher,
        profileImageTeacher,
        languagesTeacher,
        isFollowingTeacher,
    isSolve,
        level,
        questionName,
        questionId,
        optionsList,
        categoryQuestion,
        descriptionAnswer
      ];
}

class PagesPage extends Equatable {
  final String lastPage;
  final String currentPage;

  PagesPage({required this.currentPage, required this.lastPage});

  @override
  // TODO: implement props
  List<Object?> get props => [currentPage, lastPage];
}
