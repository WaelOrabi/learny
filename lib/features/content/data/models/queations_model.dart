import 'package:learny_project/features/admin/domain/entities/language_entity.dart';
import 'package:learny_project/features/auth/data/models/user_model.dart';
import 'package:learny_project/features/content/data/models/options_question_model.dart';
import 'package:learny_project/features/content/domain/entities/category_question.dart';
import 'package:learny_project/features/content/domain/entities/questions_entity.dart';
import 'level_content_model.dart';

class QuestionsModel extends QuestionsEntity {
  QuestionsModel({
    required super.teacherId,
    required super.firstNameTeacher,
    required super.lastNameTeacher,
    required super.languagesTeacher,
    required super.isFollowingTeacher,
    required super.isSolve,
    required super.level,
    required super.questionId,
    required super.questionName,
    required super.categoryQuestion,
    required super.optionsList,
    super.profileImageTeacher,
  super.descriptionAnswer,
  });

  factory QuestionsModel.fromJson(Map<String, dynamic>json){
    return QuestionsModel(
      teacherId:json['teacher_info']["info_id"].toString() ,
        firstNameTeacher: json['teacher']["first_name"].toString(),
        lastNameTeacher: json['teacher']["last_name"].toString(),
        profileImageTeacher: json['teacher']["personal_image"].toString(),
        languagesTeacher: Language(languageId: json["language_id"].toString(), languageName: json["language"].toString()),
        isFollowingTeacher: json["is_followed"],
        isSolve: json["is_solved"],
        level: LevelContentModel.fromJson(json["content_level"]),
        questionId: json["id"].toString(),
        questionName: json["question"].toString(),
        categoryQuestion: CategoryQuestionEntity(categoryId: json["category_id"].toString(), categoryName: json["category"].toString(), languageId: json["language_id"].toString()),
        optionsList: List.from(json['answers'])
            .map((e) => OptionsQuestionModel.fromJson(e))
            .toList(), );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = questionId;
    _data['content_levels_id'] = level.levelId;
    _data['question'] = questionName;
    _data['explanation'] = descriptionAnswer;
    _data['category_id'] = categoryQuestion.categoryId;
    _data['answers'] = optionsList.map((e)=>OptionsQuestionModel(optionId: e.optionId, optionName: e.optionName, isTrue: e.isTrue).toJson()).toList();
    return _data;
  }
}

class PagesPageModel extends PagesPage{
  PagesPageModel({required super.currentPage, required super.lastPage});

}
