import 'package:learny_project/features/auth/data/models/user_model.dart';
import 'package:learny_project/features/home/domain/entities/get_best_teachers_entity.dart';

class GetBestTeachersModel extends GetBestTeachersEntity{


  GetBestTeachersModel({ required super.data});

  factory GetBestTeachersModel.fromJson(Map<String, dynamic> json) {
    return GetBestTeachersModel(
      data: (json['data'] as List).map((e) => BestTeacherModel.fromJson(e)).toList(),
    );
  }
}

class BestTeacherModel extends BestTeacherEntity{


  BestTeacherModel({
    required super.teacherId,
    required super.status,
    required super.rating,
    required super.userInfo,
    required super.languages,
    required super.createdAt,
  });

  factory BestTeacherModel.fromJson(Map<String, dynamic> json) {
    return BestTeacherModel(
      teacherId: json['teacher_id'],
      status: json['status'],
      rating: json['rating'],
      userInfo: UserModel.fromJson(json['user_info']),
      languages:
      (json['languages'] as List).map((e) => LanguageModel.fromJson(e)).toList(),
      createdAt: json['created_at'],
    );
  }
}


class LanguageModel extends LanguageEntity{


  LanguageModel({
    required super.language,
    required super.level,
    required super.yearsOfExperience,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      language: json['language'],
      level: json['level'],
      yearsOfExperience: json['years_of_experience'],
    );
  }
}
