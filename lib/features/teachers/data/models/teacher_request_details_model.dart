import 'package:learny_project/features/auth/data/models/user_model.dart';
import 'package:learny_project/features/auth/domain/entities/user_entity.dart';

import '../../domain/entities/teacher_request_details_entity.dart';

class TeacherRequestDetailsModel extends TeacherRequestDetailsEntity {
  TeacherRequestDetailsModel({
    required super.teacherId,
    required super.status,
    required super.rating,
    required super.userInfo,
    required super.languages,
    required super.info,
    required super.cardId,
    required super.createdAt,
  });

  factory TeacherRequestDetailsModel.fromJson(Map<String, dynamic> json) {
    return TeacherRequestDetailsModel(
      teacherId: json['teacher_id'],
      rating: json['rating'],
      userInfo: UserModel.fromJson(json['user_info']),
      languages: List.from(json['languages'])
          .map((e) => LanguagesModel.fromJson(e))
          .toList(),
      info: InfoModel.fromJson(json['info']),
      createdAt: json['created_at'],
      cardId: CardIdModel.fromJson(json['cardId']),
      status: json['status'],
    );
  }
}

class NationalityModel extends NationalityEntity {
  NationalityModel({required super.nationalityId, required super.name});

  factory NationalityModel.fromJson(Map<String, dynamic> json) {
    return NationalityModel(
        nationalityId: json['nationality_id'], name: json['name']);
  }
}

class LanguagesModel extends LanguagesEntity {
  LanguagesModel(
      {required super.language,
      required super.level,
      required super.yearsOfExperience,
      required super.certificates});

  factory LanguagesModel.fromJson(Map<String, dynamic> json) {
    List<CertificatesModel> certificates = [];
    if (json['certificates'] != null) {
      json['certificates'].forEach((v) {
        certificates.add(CertificatesModel.fromJson(v));
      });
    }
    return LanguagesModel(
      language: json['language'],
      level: json['level'],
      yearsOfExperience: json['years_of_experience'],
      certificates: certificates,
    );
  }
}

class CertificatesModel extends CertificatesEntity {
  CertificatesModel(
      {required super.certificateImage,
      required super.certificateType,
      required super.doner});

  factory CertificatesModel.fromJson(Map<String, dynamic> json) {
    return CertificatesModel(
        certificateImage: json['certificate_image'],
        certificateType: json['certificate_type'],
        doner: DonerModel.fromJson(json['doner']));
  }
}

class DonerModel extends DonerEntity {
  DonerModel({required super.donerName, required super.donerType});

  factory DonerModel.fromJson(Map<String, dynamic> json) {
    return DonerModel(
        donerName: json['doner_name'], donerType: json['doner_type']);
  }
}

class InfoModel extends InfoEntity {
  InfoModel(
      {required super.infoId,
      required super.about,
      required super.teachingDescription,
      required super.video});

  factory InfoModel.fromJson(Map<String, dynamic> json) {
    return InfoModel(
        infoId: json['info_id'],
        about: json['about'],
        teachingDescription: json['teaching_description'],
        video: json['video']);
  }
}

class CardIdModel extends CardIdEntity {
  CardIdModel({
    required super.cardId,
    required super.nationalNumber,
    required super.frontCardImage,
    required super.backCardImage,
  });

  factory CardIdModel.fromJson(Map<String, dynamic> json) {
    return CardIdModel(
        cardId: json['card_id'],
        nationalNumber: json['national_number'],
        frontCardImage: json['front_card_image'],
        backCardImage: json['back_card_image']);
  }
}
