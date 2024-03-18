import 'package:learny_project/features/content/domain/entities/category_paragraph.dart';

class CategoryParagraphModel extends CategoryParagraphEntity {
  CategoryParagraphModel({required super.categoryId, required super.categoryName});

  factory CategoryParagraphModel.fromJson(Map<String, dynamic> json) {
    return CategoryParagraphModel(
        categoryId: json['id'].toString(),
        categoryName: json['type'].toString(),);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = categoryId;
    _data['type'] = categoryName;
    return _data;
  }
}
