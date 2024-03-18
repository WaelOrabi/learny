import 'package:learny_project/features/content/data/models/paragraphs_model.dart';
import 'package:learny_project/features/content/domain/entities/all_paragraphs_entity.dart';
import 'package:learny_project/features/content/domain/entities/questions_entity.dart';

class AllParagraphsModel extends AllParagraphsEntity {
  AllParagraphsModel({required super.pages, required super.paragraphsEntity});

  factory AllParagraphsModel.fromJson(Map<String, dynamic> json) {
    return AllParagraphsModel(
        pages: PagesPage(
            currentPage: json["meta"]["current_page"].toString(),
            lastPage: json["meta"]["last_page"].toString()),
        paragraphsEntity: List<ParagraphsModel>.from(
            json["data"].map((x) => ParagraphsModel.fromJson(x))));
  }
}
