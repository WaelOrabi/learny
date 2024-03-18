part of 'become_a_teacher_bloc.dart';

@immutable
abstract class BecomeATeacherState {}

class BecomeATeacherInitial extends BecomeATeacherState {}

class ValueUpdatedCountryState extends BecomeATeacherState {
  final String newValue;

  ValueUpdatedCountryState({required this.newValue});
}



class ValueUpdatedCityState extends BecomeATeacherState {
  final String newValue;

  ValueUpdatedCityState({required this.newValue});
}

class ValueUpdatedLanguageState extends BecomeATeacherState {
  final String newValue;

  ValueUpdatedLanguageState({required this.newValue});
}

class ValueUpdatedLevelState extends BecomeATeacherState {
  final String newValue;

  ValueUpdatedLevelState({required this.newValue});
}

class ValueUpdatedYearOfExperienceState extends BecomeATeacherState {
  final String newValue;

  ValueUpdatedYearOfExperienceState({required this.newValue});
}

class ValueUpdatedDescriptionTeachingState extends BecomeATeacherState {
  final String newValue;

  ValueUpdatedDescriptionTeachingState({required this.newValue});
}



class ValueUpdatedDonorTypeState extends BecomeATeacherState {
  final String newValue;

  ValueUpdatedDonorTypeState({required this.newValue});
}

class ValueUpdatedDonorCountryState extends BecomeATeacherState {
  final String newValue;

  ValueUpdatedDonorCountryState({required this.newValue});
}
class ValueUpdatedDonorNameState extends BecomeATeacherState {
  final String newValue;

  ValueUpdatedDonorNameState({required this.newValue});
}

class ValueUpdatedCertificateDateState extends BecomeATeacherState {
  final String newValue;

  ValueUpdatedCertificateDateState({required this.newValue});
}


class ValueUpdatedCertificateTypeState extends BecomeATeacherState {
  final String newValue;

  ValueUpdatedCertificateTypeState({required this.newValue});
}


class ValueUpdatedImageCertificateState extends BecomeATeacherState {
  final XFile imageCertificate;

  ValueUpdatedImageCertificateState({required this.imageCertificate});
}




class NewCertificateState extends BecomeATeacherState {
  List<CertificateScreen> listCertificates;

  NewCertificateState({required this.listCertificates});
}




class DeleteCertificateState extends BecomeATeacherState {
  List<CertificateScreen> listCertificates;

  DeleteCertificateState({required this.listCertificates});
}





class NewTeachingLanguagesState extends BecomeATeacherState {
  List<TeachingLanguagesScreen> listTeachingLanguagesScreen;

  NewTeachingLanguagesState({required this.listTeachingLanguagesScreen});
}




class DeleteTeachingLanguagesState extends BecomeATeacherState {
  List<TeachingLanguagesScreen> listTeachingLanguagesScreen;

  DeleteTeachingLanguagesState({required this.listTeachingLanguagesScreen});
}


class AgreeState extends BecomeATeacherState {}

class ImagePickedFrontIdCardState extends BecomeATeacherState {
  final File imageFile;

   ImagePickedFrontIdCardState({required this.imageFile});
}


class ImagePickedBackIdCardState extends BecomeATeacherState {
  final File imageFile;

  ImagePickedBackIdCardState({required this.imageFile});
}



class AddVideoState extends BecomeATeacherState {
 final String videoBase64;

  AddVideoState({required this.videoBase64});
}



class FillOfListLanguagesSuccessState extends BecomeATeacherState{
  final List<Language> listLanguages;

  FillOfListLanguagesSuccessState({required this.listLanguages});

}


class FillOfListLevelsSuccessState extends BecomeATeacherState{
  final List<Level> listLevels;

  FillOfListLevelsSuccessState({required this.listLevels});

}


class FillOfListCertificateTypeSuccessState extends BecomeATeacherState{
  final List<CertificateType> listCertificateTypes;

  FillOfListCertificateTypeSuccessState({required this.listCertificateTypes});

}



class FillOfListDonorTypesSuccessState extends BecomeATeacherState{
  final List<DonorType> listDonorTypes;

  FillOfListDonorTypesSuccessState({required this.listDonorTypes});

}


class FillOfListCountriesSuccessState extends BecomeATeacherState{
  final List<Country> listCountries;

  FillOfListCountriesSuccessState({required this.listCountries});

}



class OrderBecomeATeacherSuccessState extends BecomeATeacherState{}
class OrderBecomeATeacherErrorState extends BecomeATeacherState{
  final List<String?>messages;

  OrderBecomeATeacherErrorState({required this.messages});
}
class OrderBecomeATeacherLoadingState extends BecomeATeacherState{}


