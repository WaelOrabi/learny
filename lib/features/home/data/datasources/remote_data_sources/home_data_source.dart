
import '../../models/get_best_teachers_model.dart';
import '../../models/info_home_model.dart';
import '../../models/packages_hours_price_model.dart';
import '../../models/services_model.dart';
import '../../models/statistics_model.dart';
abstract class HomeDataSource{
  Future<InfoHomeModel> getInfoDataSource();
  Future<PackagesHoursPriceModel>getPackagesHoursPriceDataSource();
  Future<ServicesModel>getServicesDataSource();
  Future<StatisticsModel>getStatisticsDataSource();
  Future<GetBestTeachersModel>getBestTeachersDataSource();
}