import 'package:learny_project/features/content/domain/entities/category_question.dart';

class CategoryQuestionModel extends CategoryQuestionEntity {
  CategoryQuestionModel(
      {required super.categoryId,
      required super.categoryName,
      required super.description,
      required super.languageId});

  factory CategoryQuestionModel.fromJson(Map<String, dynamic> json) {
    return CategoryQuestionModel(
        categoryId: json['id'].toString(),
        categoryName: json['category_name'].toString(),
        description: json['description'].toString(),
        languageId: json['language_id'].toString());
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = categoryId;
    _data['category_name'] = categoryName;
    _data['description'] = description;
    _data['language_id'] = languageId;
    return _data;
  }
}
