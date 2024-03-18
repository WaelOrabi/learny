
import 'package:learny_project/features/teachers/domain/entities/teachers_entity.dart';

import '../../../auth/domain/entities/user_entity.dart';

class TeacherEntity {
  TeacherEntity({
    required this.teacherId,
    required this.rating,
    required this.userInfo,
    required this.languages,
    required this.info,
    required this.status,
    required this.workingDays,
    required this.createdAt,
     this.availableTimes,
  });

  int teacherId;
  double rating;
  String status;
  UserEntity userInfo;
  List<LanguageEntity> languages;
  InfoEntity info;
  DateTime createdAt;
  List<WorkingDayEntity> workingDays;
  Map<String, List<String>>? availableTimes;
}

class InfoEntity {
  InfoEntity({
    required this.infoId,
    required this.about,
    required this.teachingDescription,
    required this.video,
  });

  int infoId;
  String about;
  String teachingDescription;
  String video;
}

class LanguageEntity {
  LanguageEntity({
    required this.language,
    required this.level,
    required this.yearsOfExperience,
    required this.certificates,
  });

  String language;
  String level;
  int yearsOfExperience;
  List<CertificateEntity> certificates;
}

class CertificateEntity {
  CertificateEntity({
    required this.certificateImage,
    required this.certificateType,
    required this.doner,
  });

  String certificateImage;
  String certificateType;
  DonerEntity doner;
}

class DonerEntity {
  DonerEntity({
    required this.donerName,
    required this.donerType,
  });

  String donerName;
  String donerType;
}

