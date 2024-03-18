import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import 'package:meta/meta.dart';

import '../../../../admin/domain/entities/country_entity.dart';
import '../../../domain/usecases/countries_usecase/add_country_usecase.dart';
import '../../../domain/usecases/countries_usecase/delete_country_usecase.dart';
import '../../../domain/usecases/countries_usecase/get_all_countries_usecase.dart';

part 'country_event.dart';

part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final AddCountryUseCase addCountryUseCase;
  final DeleteCountryUseCase deleteCountryUseCase;
  final GetAllCountriesUseCase getAllCountriesUseCase;
List<Country> listCountries=[Country(countryId: "209", countryName: "Syrian Arab Republic")];
  CountryBloc(
      {required this.addCountryUseCase,
      required this.deleteCountryUseCase,
      required this.getAllCountriesUseCase})
      : super(CountryInitial()) {
    on<CountryEvent>((event, emit) {
      if (event is GetAllCountriesEvent) {
        gitAllCountries();
      } else if (event is AddCountryEvent) {
        addCountry(countryName: event.countryName);
      } else if (event is DeleteCountryEvent) {
        deleteCountry(countryId: event.countryId);
      }
    });
  }

  Future<void> gitAllCountries() async {
    emit(GetAllCountriesLoadingState());
    final failureOrCountries = await getAllCountriesUseCase();
    failureOrCountries.fold((failure) {
      emit(GetAllCountriesErrorState(message: mapFailureToMessage(failure)));
    }, (countries) {
      listCountries=countries;
      emit(GetAllCountriesSuccessState(listAllCountries: countries));
    });
  }

  Future<void> addCountry({required String countryName}) async {
    emit(AddCountryLoadingState());
    final failureOrCountries =
        await addCountryUseCase(countryName: countryName);
    failureOrCountries.fold((failure) {
      emit(AddCountryErrorState(message: mapFailureToMessage(failure)));
    }, (countries) {
      emit(AddCountrySuccessState());
    });
  }

  Future<void> deleteCountry({required String countryId}) async {
    emit(DeleteCountryLoadingState());
    final failureOrCountries = await deleteCountryUseCase(countryId: countryId);
    failureOrCountries.fold((failure) {
      emit(DeleteCountryErrorState(message: mapFailureToMessage(failure)));
    }, (countries) {
      emit(DeleteCountrySuccessState());
    });
  }
}
