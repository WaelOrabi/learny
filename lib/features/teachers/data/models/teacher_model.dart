
import 'package:intl/intl.dart';
import 'package:learny_project/features/auth/data/models/user_model.dart';
import 'package:learny_project/features/teachers/data/models/techers_model.dart';

import '../../domain/entities/teacher_entity.dart';



class TeacherModel  extends TeacherEntity{
  TeacherModel({
    required super.teacherId,
    required super.rating,
    required super.userInfo,
    required super.languages,
    required super.info,
    required super.createdAt,
    required super.availableTimes, required super.status, required super.workingDays,
  });



  factory TeacherModel.fromJson(Map<String, dynamic> json) =>
      TeacherModel(
        teacherId: json["teacher_id"],
        rating: json["rating"],
        userInfo: UserModel.fromJson(json["user_info"]),
        languages: List<LanguageModel>.from(
            json["languages"].map((x) => LanguageModel.fromJson(x))),
        info: InfoModel.fromJson(json["info"]),

        createdAt: DateTime.parse(json["created_at"]),
        availableTimes:json["available_times"]is Map? Map.from(json["available_times"]).map((k, v)
        {
          return  MapEntry<String, List<String>>(k,
              List<String>.from(v));


        }):{},
        status: json["status"],
        workingDays: List<WorkingDayModel>.from(
            json["working_days"].map((workingDay) => WorkingDayModel.fromJson(workingDay))),
      );
}

class InfoModel extends InfoEntity{
  InfoModel({
    required super.infoId,
    required super.about,
    required super.teachingDescription,
    required super.video,
  });


  factory InfoModel.fromJson(Map<String, dynamic> json) => InfoModel(
    infoId: json["info_id"],
    about: json["about"],
    teachingDescription: json["teaching_description"],
    video: json["video"],
  );
}

class LanguageModel extends LanguageEntity{
  LanguageModel({
    required super.language,
    required super.level,
    required super.yearsOfExperience,
    required super.certificates,
  });



  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
    language: json["language"],
    level: json["level"],
    yearsOfExperience: json["years_of_experience"],
    certificates: List<CertificateModel>.from(
        json["certificates"].map((x) => CertificateModel.fromJson(x))),
  );
}

class CertificateModel extends CertificateEntity{
  CertificateModel({
    required super.certificateImage,
    required super.certificateType,
    required super.doner,
  });


  factory CertificateModel.fromJson(Map<String, dynamic> json) => CertificateModel(
    certificateImage: json["certificate_image"],
    certificateType: json["certificate_type"],
    doner: DonerModel.fromJson(json["doner"]),
  );
}

class DonerModel extends DonerEntity{
  DonerModel({
    required super.donerName,
    required super.donerType,
  });


  factory DonerModel.fromJson(Map<String, dynamic> json) => DonerModel(
    donerName: json["doner_name"],
    donerType: json["doner_type"],
  );
}



