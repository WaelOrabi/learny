import 'package:equatable/equatable.dart';
import 'package:file_selector/file_selector.dart';

class BecomeATeacherEntity extends Equatable {
  InfoBecomeATeacher infoBecomeATeacher;
  CardBecomeATeacher cardBecomeATeacher;
  List<LanguageBecomeATeacher> listLanguageBecomeATeacher;

  BecomeATeacherEntity(
      {required this.infoBecomeATeacher,
      required this.cardBecomeATeacher,
      required this.listLanguageBecomeATeacher});

  @override
  List<Object?> get props =>
      [infoBecomeATeacher, cardBecomeATeacher, listLanguageBecomeATeacher];
}

class InfoBecomeATeacher {
  String firstName;
  String fatherName;
  String lastName;
  String descriptionAboutYou;
  String descriptionAboutTeachingLanguage;
  String video;

  InfoBecomeATeacher({
    required this.firstName,
    required this.fatherName,
    required this.lastName,
    required this.descriptionAboutYou,
    required this.descriptionAboutTeachingLanguage,
    required this.video,
  });
}

class CardBecomeATeacher {
  String nationalNumber;
  XFile frontCardImage;
  XFile backCardImage;

  CardBecomeATeacher({
    required this.nationalNumber,
    required this.frontCardImage,
    required this.backCardImage,
  });
}

class CertificateBecomeATeacher {
  String certificateImage;
  String certificateDate;
  String certificateTypeId;
  DonorBecomeATeacher donor;

  CertificateBecomeATeacher({
    required this.certificateImage,
    required this.certificateDate,
    required this.certificateTypeId,
    required this.donor,
  });
}

class DonorBecomeATeacher {
  String donorTypeId;
  String donorName;
  String countryId;

  DonorBecomeATeacher({
    required this.donorTypeId,
    required this.donorName,
    required this.countryId,
  });


}

class LanguageBecomeATeacher {
  String languageId;
  String languageLevelId;
  String yearsOfExperience;
  List<CertificateBecomeATeacher> certificates;

  LanguageBecomeATeacher({
    required this.languageId,
    required this.languageLevelId,
    required this.yearsOfExperience,
    required this.certificates,
  });
}
