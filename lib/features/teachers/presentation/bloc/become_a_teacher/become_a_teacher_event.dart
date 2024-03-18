part of 'become_a_teacher_bloc.dart';

@immutable
abstract class BecomeATeacherEvent {}


class UpdateValueCountryEvent extends BecomeATeacherEvent {
  final String newValue;

  UpdateValueCountryEvent({required this.newValue});

}
class UpdateValueCityEvent extends BecomeATeacherEvent {
  final String newValue;

  UpdateValueCityEvent({required this.newValue});

}
class UpdateValueLanguageEvent extends BecomeATeacherEvent {
  final String newValue;
  final String languageId;
  final int indexTeachingLanguage;
  UpdateValueLanguageEvent({required this.languageId,required this.newValue,required this.indexTeachingLanguage,});

}
class UpdateValueLevelEvent extends BecomeATeacherEvent {
  final String newValue;
  final String levelId;
  final int indexTeachingLanguage;
  UpdateValueLevelEvent({required this.newValue,required this.indexTeachingLanguage,required this.levelId});

}

class UpdateValueYearOfExperienceEvent extends BecomeATeacherEvent {
  final String newValue;
  final int indexTeachingLanguage;
  UpdateValueYearOfExperienceEvent({required this.newValue,required this.indexTeachingLanguage});

}

class UpdateValueCertificateTypeEvent extends BecomeATeacherEvent {
  final String newValue;
  final String certificateTypeId;
  final int indexTeachingLanguage;
  final int indexCertificate;
  UpdateValueCertificateTypeEvent({required this.newValue,required this.indexTeachingLanguage,required this.indexCertificate,required this.certificateTypeId});

}


class UpdateValueCertificateDateEvent extends BecomeATeacherEvent {
  final String newValue;
  final int indexTeachingLanguage;
  final int indexCertificate;
  UpdateValueCertificateDateEvent({required this.newValue,required this.indexTeachingLanguage,required this.indexCertificate});

}

class UpdateValueDonorTypeEvent extends BecomeATeacherEvent {
  final String newValue;
  final String donorTypeId;
  final int indexTeachingLanguage;
  final int indexCertificate;
  UpdateValueDonorTypeEvent({required this.newValue,required this.indexTeachingLanguage,required this.indexCertificate,required this.donorTypeId});

}



class UpdateValueDonorCountryEvent extends BecomeATeacherEvent {
  final String newValue;
  final String donorCountyId;
  final int indexTeachingLanguage;
  final int indexCertificate;
  UpdateValueDonorCountryEvent({required this.newValue,required this.indexTeachingLanguage,required this.indexCertificate,required this.donorCountyId});

}
class UpdateValueDonorNameEvent extends BecomeATeacherEvent {
  final String newValue;
  final int indexTeachingLanguage;
  final int indexCertificate;
  UpdateValueDonorNameEvent({required this.newValue,required this.indexTeachingLanguage,required this.indexCertificate});
}


class UpdateValueImageCertificateEvent extends BecomeATeacherEvent {
  final int indexTeachingLanguage;
  final int indexCertificate;
  UpdateValueImageCertificateEvent({required this.indexTeachingLanguage,required this.indexCertificate});

}


class NewCertificateEvent extends BecomeATeacherEvent {
  CertificateScreen certificateScreen;
  final int indexTeachingLanguage;

  NewCertificateEvent({required this.certificateScreen,required this.indexTeachingLanguage});
}


class DeleteCertificateEvent extends BecomeATeacherEvent {
  final int indexTeachingLanguage;
  final int indexCertificate;
  DeleteCertificateEvent({required this.indexTeachingLanguage,required this.indexCertificate});
}




class NewTeachingLanguagesEvent extends BecomeATeacherEvent {
  TeachingLanguagesScreen teachingLanguagesScreen;
  NewTeachingLanguagesEvent({required this.teachingLanguagesScreen});
}


class DeleteTeachingLanguagesEvent extends BecomeATeacherEvent {
  final int indexTeachingLanguage;

  DeleteTeachingLanguagesEvent({required this.indexTeachingLanguage});
}

class AgreeEvent extends BecomeATeacherEvent {}

class PickImageFrontEvent extends BecomeATeacherEvent {}

class PickImageBackEvent extends BecomeATeacherEvent {}

class AddVideoEvent extends BecomeATeacherEvent {
  final String videoBase64;

  AddVideoEvent({required this.videoBase64});

}

class FillOfListLanguagesEvent extends BecomeATeacherEvent{
  final List<Language> listLanguages;

  FillOfListLanguagesEvent({required this.listLanguages});

}


class FillOfListLevelsEvent extends BecomeATeacherEvent{
  final List<Level> listLevels;

  FillOfListLevelsEvent({required this.listLevels});

}


class FillOfListCertificateTypeEvent extends BecomeATeacherEvent{
  final List<CertificateType> listCertificateTypes;

  FillOfListCertificateTypeEvent({required this.listCertificateTypes});

}



class FillOfListDonorTypesEvent extends BecomeATeacherEvent{
  final List<DonorType> listDonorTypes;

  FillOfListDonorTypesEvent({required this.listDonorTypes});

}


class FillOfListCountriesEvent extends BecomeATeacherEvent{
  final List<Country> listCountries;

  FillOfListCountriesEvent({required this.listCountries});

}



class OrderBecomeATeacherEvent extends BecomeATeacherEvent{
  final BecomeATeacherEntity becomeATeacherEntity;

  OrderBecomeATeacherEvent({required this.becomeATeacherEntity});

}






