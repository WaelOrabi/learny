import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/entities/language_entity.dart';
import '../../../domain/usecases/languages_usecae/add_language_usecase.dart';
import '../../../domain/usecases/languages_usecae/delete_language_usecase.dart';
import '../../../domain/usecases/languages_usecae/get_all_language_usecase.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final AddLanguageUseCase addLanguageUseCase;
  final GetAllLanguagesUseCase getAllLanguagesUseCase;
  final DeleteLanguageUseCase deleteLanguageUseCase;
  List<Language> listLanguages=[Language(languageId: "1", languageName: "English")];
  LanguageBloc(
      {required this.addLanguageUseCase,
     required this.getAllLanguagesUseCase,
     required this.deleteLanguageUseCase}) : super(LanguageInitial()) {
    on<LanguageEvent>((event, emit) {
      if (event is GetAllLanguagesEvent) {
        gitAllLanguages();
      } else if (event is AddLanguageEvent) {
        addLanguage(languageName: event.languageName);
      } else if (event is DeleteLanguageEvent) {
        deleteLanguage(languageId: event.languageId);
      }
    });
  }

  Future<void> gitAllLanguages() async {
    emit(GetAllLanguagesLoadingState());
    final failureOrLanguages = await getAllLanguagesUseCase();
    failureOrLanguages.fold((failure) {
      emit(GetAllLanguagesErrorState(message: mapFailureToMessage(failure)));
    }, (languages) {
      listLanguages=languages;
      emit(GetAllLanguagesSuccessState(listAllLanguages: languages));
    });
  }

  Future<void> addLanguage({required String languageName}) async {
    emit(AddLanguageLoadingState());
    final failureOrLanguages =
    await addLanguageUseCase(languageName: languageName);
    failureOrLanguages.fold((failure) {
      emit(AddLanguageErrorState(message: mapFailureToMessage(failure)));
    }, (languages) {
      emit(AddLanguageSuccessState());
    });
  }

  Future<void> deleteLanguage({required String languageId}) async {
    emit(DeleteLanguageLoadingState());
    final failureOrLanguages = await deleteLanguageUseCase(languageId: languageId);
    failureOrLanguages.fold((failure) {
      emit(DeleteLanguageErrorState(message: mapFailureToMessage(failure)));
    }, (languages) {
      emit(DeleteLanguageSuccessState());
    });
  }

}
