import 'package:equatable/equatable.dart';


class CategoryParagraphEntity extends Equatable {
  String categoryId;
  String categoryName;
  CategoryParagraphEntity(
      {required this.categoryId,
        required this.categoryName,

      });

  @override
  List<Object?> get props => [
    categoryName,
    categoryId,
  ];
}
