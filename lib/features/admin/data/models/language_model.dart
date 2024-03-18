import '../../domain/entities/language_entity.dart';

class LanguageModel extends Language{
  LanguageModel({required super.languageId, required super.languageName});
  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
        languageId: json['id'].toString(),
        languageName: json['language_name'].toString()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': languageId,
      'language_name': languageName,
    };
  }

}