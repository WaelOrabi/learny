import 'package:learny_project/features/content/data/models/queations_model.dart';
import 'package:learny_project/features/content/domain/entities/all_questions_entity.dart';
import 'package:learny_project/features/content/domain/entities/questions_entity.dart';

class AllQuestionsModel extends AllQuestionsEntity {
  AllQuestionsModel({required super.pages, required super.questionsEntity});

  factory AllQuestionsModel.fromJson(Map<String, dynamic> json) {
    return AllQuestionsModel(
        pages: PagesPage(
            currentPage: json["meta"]["current_page"].toString(),
            lastPage: json["meta"]["last_page"].toString()),
        questionsEntity: List<QuestionsModel>.from(
            json["data"].map((x) => QuestionsModel.fromJson(x))));
  }
}
