import 'dart:convert';
import 'dart:io';
import 'dart:html' as html;
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../admin/domain/entities/language_entity.dart';
import '../../../../admin/domain/entities/level_entity.dart';
import '../../../../admin/presentation/bloc/language_bloc/language_bloc.dart';
import '../../../../admin/presentation/bloc/level_bloc/level_bloc.dart';
import '../../../domain/entities/teaching_languages.dart';
import '../../../../admin/domain/entities/certificate_type_entity.dart';
import '../../../../admin/domain/entities/country_entity.dart';
import '../../../../admin/domain/entities/donor_type_entity.dart';
import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/entities/become_a_teacher_entity.dart';
import '../../../domain/entities/certificate.dart';
import '../../../domain/entities/donor_certificate.dart';
import '../../../domain/usecases/order_become_a_teacher_usecase.dart';
import '../../widgets/becom_a_teacher_widgets/certificate.dart';
import '../../widgets/becom_a_teacher_widgets/teaching_languages_screen.dart';

part 'become_a_teacher_event.dart';

part 'become_a_teacher_state.dart';

class BecomeATeacherBloc extends Bloc<BecomeATeacherEvent, BecomeATeacherState>
    with ChangeNotifier {
  bool isAgree = false;
  List<XFile?> listImageCard = [null, null];
  TextEditingController firstNameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController idCardController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController descriptionTeachingController = TextEditingController();
  DateTime dateCertificate = DateTime.now();
  String videoBase64 = '';
  List<Language> listLanguages = [];
  List<Level> listLevels = [];
  List<CertificateType> listCertificateTypes = [];
  List<DonorType> listDonorTypes = [];
  List<Country> listCountries = [];

  List<TeachingLanguagesScreen> listTeachingLanguagesScreens = [
    TeachingLanguagesScreen(
      teachingLanguages: TeachingLanguages(
          language: Language(languageId: "1", languageName: "English"),
          level: Level(levelId: "1", levelName: "A1", levelDescription: ""),
          yearOfExperience: TextEditingController(),
          listCertificateScreen: [
            CertificateScreen(
                certificate: Certificate(
                    certificateType: CertificateType(
                        certificateTypeId: "1",
                        certificateTypeName: "Master's"),
                    dateCertificate: "",
                    donorCertificate: DonorCertificate(
                        donorType: DonorType(
                            donorTypeId: "1",
                            donorTypeName: "Academic education"),
                        donorName: TextEditingController(),
                        donorCountry: Country(
                            countryId: "209",
                            countryName: "Syrian Arab Republic")),
                    imageCertificate: XFile(""),
                    imagesOfCertificate: ''),
                indexCertificate: 0,
                indexTeachingLanguage: 0,
                visibleDelete: false)
          ]),
      indexTeachingLanguage: 0,
      deleteVisibility: false,
      listLanguages: [Language(languageId: "1", languageName: "English")],
      listLevels: [Level(levelId: "1", levelName: "A1", levelDescription: "")],
    )
  ];

  OrderBecomeATeacherUseCase orderBecomeATeacherUseCase;

  BecomeATeacherBloc({required this.orderBecomeATeacherUseCase})
      : super(BecomeATeacherInitial()) {
    on<BecomeATeacherEvent>((event, emit) async {
      if (event is OrderBecomeATeacherEvent) {
        orderBecomeATeacher(becomeATeacherEntity: event.becomeATeacherEntity);
      } else if (event is UpdateValueLanguageEvent) {
        updateValueLanguage(
            newValue: event.newValue,
            indexTeachingLanguage: event.indexTeachingLanguage,
            languageId: event.languageId);
      } else if (event is UpdateValueLevelEvent) {
        updateValueLevel(
            newValue: event.newValue,
            indexTeachingLanguage: event.indexTeachingLanguage,
            levelId: event.levelId);
      } else if (event is UpdateValueYearOfExperienceEvent) {
        updateValueYearOfExperience(
            newValue: event.newValue,
            indexTeachingLanguage: event.indexTeachingLanguage);
      } else if (event is UpdateValueCertificateTypeEvent) {
        updateValueCertificateType(
            newValue: event.newValue,
            indexTeachingLanguage: event.indexTeachingLanguage,
            indexCertificate: event.indexCertificate,
            certificateTypeId: event.certificateTypeId);
      } else if (event is UpdateValueCertificateDateEvent) {
        updateValueCertificateDate(
            newValue: event.newValue,
            indexTeachingLanguage: event.indexTeachingLanguage,
            indexCertificate: event.indexCertificate);
      } else if (event is UpdateValueDonorTypeEvent) {
        updateValueDonorType(
            newValue: event.newValue,
            indexTeachingLanguage: event.indexTeachingLanguage,
            indexCertificate: event.indexCertificate,
            donorTypeId: event.donorTypeId);
      } else if (event is UpdateValueDonorCountryEvent) {
        updateValueDonorCountry(
            newValue: event.newValue,
            indexTeachingLanguage: event.indexTeachingLanguage,
            indexCertificate: event.indexCertificate,
            donorCountyId: event.donorCountyId);
      } else if (event is UpdateValueDonorNameEvent) {
        updateValueDonorName(
            newValue: event.newValue,
            indexTeachingLanguage: event.indexTeachingLanguage,
            indexCertificate: event.indexCertificate);
      } else if (event is UpdateValueImageCertificateEvent) {
        await updateValueImageCertificate(
            indexTeachingLanguage: event.indexTeachingLanguage,
            indexCertificate: event.indexCertificate);
      } else if (event is NewCertificateEvent) {
        addNewCertificate(
            certificateScreen: event.certificateScreen,
            indexTeachingLanguage: event.indexTeachingLanguage);
      } else if (event is DeleteCertificateEvent) {
        deleteCertificate(
            indexTeachingLanguage: event.indexTeachingLanguage,
            indexCertificate: event.indexCertificate);
      } else if (event is NewTeachingLanguagesEvent) {
        addNewTeachingLanguages(
            teachingLanguagesScreen: event.teachingLanguagesScreen);
      } else if (event is DeleteTeachingLanguagesEvent) {
        deleteTeachingLanguage(
            indexTeachingLanguage: event.indexTeachingLanguage);
      } else if (event is AgreeEvent) {
        isAgreePrivacyPolicy();
      } else if (event is PickImageFrontEvent) {
        await imagePicker(nameImage: "front");
      } else if (event is PickImageBackEvent) {
        await imagePicker(nameImage: "back");
      } else if (event is AddVideoEvent) {
        videoBase64 = event.videoBase64;
        emit(AddVideoState(videoBase64: videoBase64));
      } else if (event is FillOfListCertificateTypeEvent) {
        listCertificateTypes = event.listCertificateTypes;
        emit(FillOfListCertificateTypeSuccessState(
            listCertificateTypes: listCertificateTypes));
      } else if (event is FillOfListCountriesEvent) {
        listCountries = event.listCountries;
        emit(FillOfListCountriesSuccessState(listCountries: listCountries));
      } else if (event is FillOfListDonorTypesEvent) {
        listDonorTypes = event.listDonorTypes;
        emit(FillOfListDonorTypesSuccessState(listDonorTypes: listDonorTypes));
      } else if (event is FillOfListLanguagesEvent) {
        listLanguages = event.listLanguages;
        emit(FillOfListLanguagesSuccessState(listLanguages: listLanguages));
      } else if (event is FillOfListLevelsEvent) {
        listLevels = event.listLevels;
        emit(FillOfListLevelsSuccessState(listLevels: listLevels));
      }
    });
  }

  void deleteTeachingLanguage({required int indexTeachingLanguage}) {
    listTeachingLanguagesScreens.removeAt(indexTeachingLanguage);
    emit(DeleteTeachingLanguagesState(
        listTeachingLanguagesScreen: listTeachingLanguagesScreens));
  }

  void addNewTeachingLanguages(
      {required TeachingLanguagesScreen teachingLanguagesScreen}) {
    listTeachingLanguagesScreens.add(teachingLanguagesScreen);
    emit(NewTeachingLanguagesState(
        listTeachingLanguagesScreen: listTeachingLanguagesScreens));
  }

  void deleteCertificate(
      {required int indexTeachingLanguage, required int indexCertificate}) {
    listTeachingLanguagesScreens[indexTeachingLanguage]
        .teachingLanguages
        .listCertificateScreen
        .removeAt(indexCertificate);
    emit(DeleteCertificateState(
        listCertificates: listTeachingLanguagesScreens[indexTeachingLanguage]
            .teachingLanguages
            .listCertificateScreen));
  }

  void addNewCertificate(
      {required CertificateScreen certificateScreen,
      required int indexTeachingLanguage}) {
    listTeachingLanguagesScreens[indexTeachingLanguage]
        .teachingLanguages
        .listCertificateScreen
        .add(certificateScreen);
    emit(NewCertificateState(
        listCertificates: listTeachingLanguagesScreens[indexTeachingLanguage]
            .teachingLanguages
            .listCertificateScreen));
  }

  void updateValueLanguage(
      {required String newValue,
      required int indexTeachingLanguage,
      required String languageId}) {
    listTeachingLanguagesScreens[indexTeachingLanguage]
        .teachingLanguages
        .language
        .languageName = newValue;
    listTeachingLanguagesScreens[indexTeachingLanguage]
        .teachingLanguages
        .language
        .languageId = languageId;

    emit(ValueUpdatedLanguageState(
        newValue: listTeachingLanguagesScreens[indexTeachingLanguage]
            .teachingLanguages
            .language
            .languageName));
  }

  void updateValueLevel(
      {required String newValue,
      required int indexTeachingLanguage,
      required String levelId}) {
    listTeachingLanguagesScreens[indexTeachingLanguage]
        .teachingLanguages
        .level
        .levelName = newValue;
    listTeachingLanguagesScreens[indexTeachingLanguage]
        .teachingLanguages
        .level
        .levelId = levelId;
    emit(ValueUpdatedLevelState(
        newValue: listTeachingLanguagesScreens[indexTeachingLanguage]
            .teachingLanguages
            .level
            .levelName));
  }

  void updateValueYearOfExperience(
      {required String newValue, required int indexTeachingLanguage}) {
    listTeachingLanguagesScreens[indexTeachingLanguage]
        .teachingLanguages
        .yearOfExperience
        .text = newValue;
    emit(ValueUpdatedYearOfExperienceState(
        newValue: listTeachingLanguagesScreens[indexTeachingLanguage]
            .teachingLanguages
            .yearOfExperience
            .text));
  }

  void updateValueCertificateType(
      {required String newValue,
      required int indexTeachingLanguage,
      required int indexCertificate,
      required String certificateTypeId}) {
    listTeachingLanguagesScreens[indexTeachingLanguage]
        .teachingLanguages
        .listCertificateScreen[indexCertificate]
        .certificate
        .certificateType
        .certificateTypeName = newValue;

    listTeachingLanguagesScreens[indexTeachingLanguage]
        .teachingLanguages
        .listCertificateScreen[indexCertificate]
        .certificate
        .certificateType
        .certificateTypeId = certificateTypeId;

    emit(ValueUpdatedCertificateTypeState(
        newValue: listTeachingLanguagesScreens[indexTeachingLanguage]
            .teachingLanguages
            .listCertificateScreen[indexCertificate]
            .certificate
            .certificateType
            .certificateTypeName));
  }

  void updateValueCertificateDate(
      {required String newValue,
      required int indexTeachingLanguage,
      required int indexCertificate}) {
    listTeachingLanguagesScreens[indexTeachingLanguage]
        .teachingLanguages
        .listCertificateScreen[indexCertificate]
        .certificate
        .dateCertificate = newValue;
    emit(ValueUpdatedCertificateDateState(
        newValue: listTeachingLanguagesScreens[indexTeachingLanguage]
            .teachingLanguages
            .listCertificateScreen[indexCertificate]
            .certificate
            .dateCertificate));
  }

  void updateValueDonorType(
      {required String newValue,
      required int indexTeachingLanguage,
      required int indexCertificate,
      required String donorTypeId}) {
    listTeachingLanguagesScreens[indexTeachingLanguage]
        .teachingLanguages
        .listCertificateScreen[indexCertificate]
        .certificate
        .donorCertificate
        .donorType
        .donorTypeName = newValue;

    listTeachingLanguagesScreens[indexTeachingLanguage]
        .teachingLanguages
        .listCertificateScreen[indexCertificate]
        .certificate
        .donorCertificate
        .donorType
        .donorTypeId = donorTypeId;

    emit(ValueUpdatedDonorTypeState(
        newValue: listTeachingLanguagesScreens[indexTeachingLanguage]
            .teachingLanguages
            .listCertificateScreen[indexCertificate]
            .certificate
            .donorCertificate
            .donorType
            .donorTypeName));
  }

  void updateValueDonorCountry(
      {required String newValue,
      required int indexTeachingLanguage,
      required int indexCertificate,
      required String donorCountyId}) {
    listTeachingLanguagesScreens[indexTeachingLanguage]
        .teachingLanguages
        .listCertificateScreen[indexCertificate]
        .certificate
        .donorCertificate
        .donorCountry
        .countryName = newValue;

    listTeachingLanguagesScreens[indexTeachingLanguage]
        .teachingLanguages
        .listCertificateScreen[indexCertificate]
        .certificate
        .donorCertificate
        .donorCountry
        .countryId = donorCountyId;
    emit(ValueUpdatedDonorCountryState(
        newValue: listTeachingLanguagesScreens[indexTeachingLanguage]
            .teachingLanguages
            .listCertificateScreen[indexCertificate]
            .certificate
            .donorCertificate
            .donorCountry
            .countryName));
  }

  void updateValueDonorName(
      {required String newValue,
      required int indexTeachingLanguage,
      required int indexCertificate}) {
    listTeachingLanguagesScreens[indexTeachingLanguage]
        .teachingLanguages
        .listCertificateScreen[indexCertificate]
        .certificate
        .donorCertificate
        .donorName
        .text = newValue;
    emit(ValueUpdatedDonorCountryState(
        newValue: listTeachingLanguagesScreens[indexTeachingLanguage]
            .teachingLanguages
            .listCertificateScreen[indexCertificate]
            .certificate
            .donorCertificate
            .donorName
            .text));
  }

  Future<void> updateValueImageCertificate(
      {required int indexTeachingLanguage,
      required int indexCertificate}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      listTeachingLanguagesScreens[indexTeachingLanguage]
          .teachingLanguages
          .listCertificateScreen[indexCertificate]
          .certificate
          .imageCertificate = pickedFile;
      var imageCertificateBytes = await pickedFile.readAsBytes();
      String imageCertificate = base64Encode(imageCertificateBytes);
      listTeachingLanguagesScreens[indexTeachingLanguage]
              .teachingLanguages
              .listCertificateScreen[indexCertificate]
              .certificate
              .imagesOfCertificate =
          "data:image/${pickedFile.name.split(".").last};base64,$imageCertificate";
      emit(ValueUpdatedImageCertificateState(
          imageCertificate: listTeachingLanguagesScreens[indexTeachingLanguage]
              .teachingLanguages
              .listCertificateScreen[indexCertificate]
              .certificate
              .imageCertificate));
    }
  }

  void isAgreePrivacyPolicy() {
    isAgree = !isAgree;
    emit(AgreeState());
  }

  Future<void> imagePicker({required String nameImage}) async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (nameImage == "front") {
        listImageCard[0] = pickedFile;
        emit(ImagePickedFrontIdCardState(
            imageFile: File(listImageCard[0]!.path)));
      } else if (nameImage == "back") {
        listImageCard[1] = pickedFile;
        emit(ImagePickedBackIdCardState(
            imageFile: File(listImageCard[1]!.path)));
      }
    }
  }

  //
  // Future<void> addVideo() async {
  //   final picker = ImagePicker();
  //   videoXFile = (await picker.pickVideo(source: ImageSource.gallery))!;
  //   if (videoXFile != null) {
  //     emit(AddVideoState(videoFile: File(videoXFile.path)));
  //   }
  // }

  Future<void> orderBecomeATeacher(
      {required BecomeATeacherEntity becomeATeacherEntity}) async {
    emit(OrderBecomeATeacherLoadingState());
    final failureOrUser = await orderBecomeATeacherUseCase(
        becomeATeacherEntity: becomeATeacherEntity);
    failureOrUser.fold((failure) {
      emit(OrderBecomeATeacherErrorState(
          messages: mapFailureToMessage(failure)));
    }, (r) {
      print("success");
      emit(OrderBecomeATeacherSuccessState());
      restVariables();
    });
  }

  void restVariables() {
    isAgree = false;
    listImageCard = [null, null];
    firstNameController = TextEditingController();
    fatherNameController = TextEditingController();
    lastNameController = TextEditingController();
    idCardController = TextEditingController();
    descriptionController = TextEditingController();
    descriptionTeachingController = TextEditingController();
    dateCertificate = DateTime.now();
    videoBase64 = '';

    listTeachingLanguagesScreens = [
      TeachingLanguagesScreen(
        teachingLanguages: TeachingLanguages(
            language: Language(languageId: "1", languageName: "English"),
            level: Level(levelId: "1", levelName: "A1", levelDescription: ""),
            yearOfExperience: TextEditingController(),
            listCertificateScreen: [
              CertificateScreen(
                  certificate: Certificate(
                      certificateType: CertificateType(
                          certificateTypeId: "1",
                          certificateTypeName: "Master's"),
                      dateCertificate: "",
                      donorCertificate: DonorCertificate(
                          donorType: DonorType(
                              donorTypeId: "1",
                              donorTypeName: "Academic education"),
                          donorName: TextEditingController(),
                          donorCountry: Country(
                              countryId: "209",
                              countryName: "Syrian Arab Republic")),
                      imageCertificate: XFile(""),
                      imagesOfCertificate: ''),
                  indexCertificate: 0,
                  indexTeachingLanguage: 0,
                  visibleDelete: false)
            ]),
        indexTeachingLanguage: 0,
        deleteVisibility: false,
        listLanguages: [Language(languageId: "1", languageName: "English")],
        listLevels: [
          Level(levelId: "1", levelName: "A1", levelDescription: "")
        ],
      )
    ];
  }
}
