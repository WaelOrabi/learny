import 'package:learny_project/features/auth/domain/entities/user_entity.dart';

class GetBestTeachersEntity {

  final List<BestTeacherEntity> data;

  GetBestTeachersEntity({ required this.data});

}

class BestTeacherEntity {
  final int teacherId;
  final String status;
  final double rating;
  final UserEntity userInfo;
  final List<LanguageEntity> languages;
  final String createdAt;

  BestTeacherEntity({
    required this.teacherId,
    required this.status,
    required this.rating,
    required this.userInfo,
    required this.languages,
    required this.createdAt,
  });


}


class LanguageEntity {
  final String language;
  final String level;
  final int yearsOfExperience;

  LanguageEntity({
    required this.language,
    required this.level,
    required this.yearsOfExperience,
  });

}
