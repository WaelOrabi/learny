import 'package:learny_project/features/content/domain/entities/options_question_entity.dart';

class OptionsQuestionModel extends OptionsQuestionEntity {
  OptionsQuestionModel(
      {required super.optionId,
      required super.optionName,
      required super.isTrue});

  factory OptionsQuestionModel.fromJson(Map<String, dynamic> json) {
    return OptionsQuestionModel(
        optionId: json["id"].toString(),
        optionName: json["answer"].toString(),
        isTrue: json["correct"]);
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = optionId;
    _data['answer'] = optionName;
    _data['correct'] = isTrue==true?1:0;
    return _data;
  }
}
