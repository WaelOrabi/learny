
import 'package:learny_project/features/home/domain/entities/info_home_entity.dart';

class InfoHomeModel extends InfoHomeEntity {


  InfoHomeModel({required super.aboutUs, required super.termsOfService});

  factory InfoHomeModel.fromJson(Map<String, dynamic> json) {
    return InfoHomeModel(
      aboutUs: json['about_us'],
      termsOfService: json['terms_of_service'],
    );
  }
}
