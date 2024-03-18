import 'package:learny_project/features/auth/domain/entities/user_entity.dart';

class TeacherRequestDetailsEntity {
  TeacherRequestDetailsEntity({
    required this.teacherId,
    required this.status,
    required this.rating,
    required this.userInfo,
    required this.languages,
    required this.info,
    required this.cardId,
    required this.createdAt,
  });

  late final int teacherId;
  late final double rating;
  late final String status;
  late final UserEntity userInfo;
  late final List<LanguagesEntity> languages;
  late final InfoEntity info;
  late final CardIdEntity cardId;
  late final String createdAt;
}

class LanguagesEntity {
  final String language;
  final String level;
  final int yearsOfExperience;
  final List<CertificatesEntity> certificates;

  LanguagesEntity(
      {required this.language,
      required this.level,
      required this.yearsOfExperience,
      required this.certificates});
}

class CertificatesEntity {
  String certificateImage;
  String certificateType;
  DonerEntity doner;

  CertificatesEntity(
      {required this.certificateImage,
      required this.certificateType,
      required this.doner});
}

class DonerEntity {
  String donerName;
  String donerType;

  DonerEntity({required this.donerName, required this.donerType});
}

class InfoEntity {
  int infoId;
  String about;
  String teachingDescription;
  String video;

  InfoEntity(
      {required this.infoId,
      required this.about,
      required this.teachingDescription,
      required this.video});
}

class CardIdEntity {
  CardIdEntity({
    required this.cardId,
    required this.nationalNumber,
    required this.frontCardImage,
    required this.backCardImage,
  });

  late final int cardId;
  late final String nationalNumber;
  late final String frontCardImage;
  late final String backCardImage;
}
