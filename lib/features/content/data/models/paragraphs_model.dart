import 'package:learny_project/features/admin/data/models/language_model.dart';
import 'package:learny_project/features/content/data/models/category_paragraph_model.dart';
import 'package:learny_project/features/content/data/models/category_question_model.dart';
import 'package:learny_project/features/content/data/models/level_content_model.dart';
import 'package:learny_project/features/content/domain/entities/paragraphs_entity.dart';

class ParagraphsModel extends ParagraphsEntity {
  ParagraphsModel(
      {required super.teacherId,
      required super.firstNameTeacher,
      required super.lastNameTeacher,
      required super.languageParagraph,
      required super.isFollowingTeacher,
      required super.level,
      required super.paragraphId,
      required super.paragraphName,
      required super.categoryParagraph,
      super.profileImageTeacher
      });
  factory ParagraphsModel.fromJson(Map<String,dynamic>json){
      return ParagraphsModel(
          teacherId: json["teacher"]["teacher_id"].toString(),
          firstNameTeacher: json["teacher"]["user_info"]["first_name"].toString(),
          lastNameTeacher: json["teacher"]["user_info"]["last_name"].toString(),
          profileImageTeacher: json["teacher"]["user_info"]["personal_image"].toString(),
          languageParagraph: LanguageModel.fromJson(json["language"]),
          isFollowingTeacher: json["is_followed"],
          level: LevelContentModel.fromJson(json["content_levels"]),
          paragraphId: json["id"].toString(),
          paragraphName: json["paragraph"].toString(),
          categoryParagraph: CategoryParagraphModel.fromJson(json["category"]));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = paragraphId;
    _data['paragraph'] = paragraphName;
    _data['paragraph_category_id'] = categoryParagraph.categoryId;
    _data['language_id'] = languageParagraph.languageId;
    _data['content_levels_id'] = level.levelId;
     return _data;
  }

}
