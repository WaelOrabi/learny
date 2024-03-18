part of 'packages_hours_price_bloc.dart';

@immutable
abstract class PackagesHoursPriceState {}

class PackagesHoursPriceInitial extends PackagesHoursPriceState {}
class PackagesHoursPriceLoadingState extends PackagesHoursPriceState{}
class PackagesHoursPriceLoadedState extends PackagesHoursPriceState{
  final PackagesHoursPriceEntity packagesHoursPriceEntity;

  PackagesHoursPriceLoadedState({required this.packagesHoursPriceEntity});
}
class PackagesHoursPriceErrorState extends PackagesHoursPriceState{
  final List<String>message;

  PackagesHoursPriceErrorState({required this.message});
}