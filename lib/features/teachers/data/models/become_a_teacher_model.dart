import 'dart:convert';
import '../../domain/entities/become_a_teacher_entity.dart';

class BecomeATeacherModel extends BecomeATeacherEntity{
  BecomeATeacherModel({required super.infoBecomeATeacher,
    required super.cardBecomeATeacher,
    required super.listLanguageBecomeATeacher});
  Future<Map<String, dynamic>>toJson ()async{
    final Map<String, dynamic> data = <String, dynamic>{};
    data['info[first_name]'] = infoBecomeATeacher.firstName;
    data['info[father_name]'] = infoBecomeATeacher.fatherName;
    data['info[last_name]'] = infoBecomeATeacher.lastName;
    data['info[about]'] = infoBecomeATeacher.descriptionAboutYou;
    data['info[teaching_description]'] = infoBecomeATeacher.descriptionAboutTeachingLanguage;
    data['info[video]']= infoBecomeATeacher.video;
    data['card[national_number]'] = cardBecomeATeacher.nationalNumber;
    List<int>  imageFrontBytes = await cardBecomeATeacher.frontCardImage.readAsBytes();
    String imageFront=base64Encode(imageFrontBytes);
    data['card[front_card_image]']= "data:image/${cardBecomeATeacher.frontCardImage.name.split(".").last};base64,$imageFront";
    List<int> imageBackBytes = await cardBecomeATeacher.backCardImage.readAsBytes();
    String imageBack=base64Encode(imageBackBytes);
    data['card[back_card_image]']= "data:image/${cardBecomeATeacher.backCardImage.name.split(".").last};base64,$imageBack";
    data['languages'] = await Future.wait(listLanguageBecomeATeacher.map((e) {
      return LanguageBecomeATeacherModel(
        languageId: e.languageId,
        languageLevelId: e.languageLevelId,
        yearsOfExperience: e.yearsOfExperience,
        certificates: e.certificates,
      ).toJson();
    }).toList());
    return data;
  }
}
class LanguageBecomeATeacherModel extends LanguageBecomeATeacher{
  LanguageBecomeATeacherModel({required super.languageId,
    required super.languageLevelId,
    required super.yearsOfExperience,
    required super.certificates});
  Future<Map<String, dynamic>>toJson ()async{
    final Map<String, dynamic> data = <String, dynamic>{};
    data['language_id'] = languageId;
    data['language_level_id'] = languageLevelId;
    data['years_of_experience'] = yearsOfExperience;
    data['certificates'] = await Future.wait(certificates.map((e) {
      return CertificateBecomeATeacherModel(
        certificateImage: e.certificateImage,
        certificateDate: e.certificateDate,
        certificateTypeId: e.certificateTypeId,
        donor: e.donor,
      ).toJson();
    }).toList());
    return data;
  }
}

class CertificateBecomeATeacherModel extends CertificateBecomeATeacher{
  CertificateBecomeATeacherModel({required super.certificateImage,
    required super.certificateDate,
    required super.certificateTypeId,
    required super.donor});
  Future<Map<String, dynamic>>toJson () async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['certificate_image']= certificateImage;
    data['certificate_date'] = certificateDate;
    data['certificate_type_id'] = certificateTypeId;
    data['doner'] = DonorBecomeATeacherModel(donorTypeId: donor.donorTypeId, donorName: donor.donorName, countryId: donor.countryId).toJson();

    return data;
  }
}

class DonorBecomeATeacherModel extends DonorBecomeATeacher{
  DonorBecomeATeacherModel({required super.donorTypeId, required super.donorName, required super.countryId});
  Map<String ,dynamic>toJson (){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doner_type_id'] = donorTypeId;
    data['doner_name'] = donorName;
    data['country_id'] = countryId;

    return data;
  }
}