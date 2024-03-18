import 'package:equatable/equatable.dart';


class CategoryQuestionEntity extends Equatable {
  String categoryId;
  String categoryName;
  String? description;
  String languageId;
  CategoryQuestionEntity(
      {required this.categoryId,
        required this.categoryName,
         this.description,
        required this.languageId,
        });

  @override
  List<Object?> get props => [
    categoryName,
    categoryId,
    description,
    languageId
  ];
}
