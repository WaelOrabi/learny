import 'package:dio/dio.dart';
import 'package:learny_project/features/home/data/datasources/remote_data_sources/home_data_source.dart';
import 'package:learny_project/features/home/data/models/get_best_teachers_model.dart';
import 'package:learny_project/features/home/data/models/packages_hours_price_model.dart';
import 'package:learny_project/features/home/data/models/services_model.dart';
import 'package:learny_project/features/home/data/models/statistics_model.dart';
import 'package:learny_project/features/teachers/data/models/teacher_model.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/strings/api_end_point.dart';
import '../../../../auth/data/datasources/remote_data_sources/helper_function_auth_remote_data_sourcess.dart';
import '../../models/info_home_model.dart';

class HomeDataSourceImpl extends HomeDataSource {
  late final Dio dio;

  HomeDataSourceImpl() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: BASE_URL,
      receiveDataWhenStatusError: true,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'lang': 'en'
      },
    );
    dio = Dio(baseOptions);
  }

  @override
  Future<InfoHomeModel> getInfoDataSource() async {
    try {
      final response = await dio.get(GET_INFO);
      if (response.statusCode == 200) {
        final InfoHomeModel infoModel =
            InfoHomeModel.fromJson(response.data['data']);
        return Future.value(infoModel);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      handleDioError(error);
    } catch (error) {
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<PackagesHoursPriceModel> getPackagesHoursPriceDataSource() async {
    try {
      final response = await dio.get(GET_PACKAGES_HOURS_PRICE);
      if (response.statusCode == 200) {
        final PackagesHoursPriceModel packageHoursPriceModel =
            PackagesHoursPriceModel.fromJson(response.data);
        return Future.value(packageHoursPriceModel);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      handleDioError(error);
    } catch (error) {
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<ServicesModel> getServicesDataSource() async{
    try {
      final response =
          await dio.get(GET_SERVICES);
      if (response.statusCode == 200) {
        final ServicesModel servicesModel=ServicesModel.fromJson(response.data);
        return Future.value(servicesModel);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      handleDioError(error);
    } catch (error) {
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<StatisticsModel> getStatisticsDataSource()async {
    try {
      final response =
          await dio.get(GET_STATISTICS);
      if (response.statusCode == 200) {
        final StatisticsModel statisticsModel=StatisticsModel.fromJson(response.data['data']);
        return Future.value(statisticsModel);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      handleDioError(error);
    } catch (error) {
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<GetBestTeachersModel> getBestTeachersDataSource() async{
    try {
      final response =
          await dio.get(GET_BEST_TEACHER);
      if (response.statusCode == 200) {
        final GetBestTeachersModel getBestTeachersModel=GetBestTeachersModel.fromJson(response.data);
        return Future.value(getBestTeachersModel);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      handleDioError(error);
    } catch (error) {
      throw ServerException();
    }
    throw ServerException();
  }
}
