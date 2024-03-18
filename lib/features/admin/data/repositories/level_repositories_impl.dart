import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/level_entity.dart';
import '../../domain/repositories/level_repository.dart';
import '../datasources/remote_data_sources/level_remote_data_source/level_remote_data_source.dart';


import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';

class LevelRepositoriesImpl implements LevelRepository{
  final LevelRemoteDataSource levelRemoteDataSource;
  final NetworkInfo networkInfo;

  LevelRepositoriesImpl({required this.levelRemoteDataSource,required this.networkInfo});
  @override
  Future<Either<Failure, Unit>> addLevel({required String levelName, required String levelDescription}) {
    // TODO: implement addLevel
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deleteLevel({required String levelId}) {
    // TODO: implement deleteLevel
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Level>>> getAllLevels()  async {
    if (await networkInfo.isConnected) {
      try {
        final  levels=  await levelRemoteDataSource.getAllLevels();
        List<Level> listLevel=[];
        listLevel.addAll(levels.map((e) => Level(levelId: e.levelId, levelName: e.levelName, levelDescription: e.levelDescription??'')).toList());
        return  Right(listLevel);
      } catch (error) {
        if (error is WrongDataException) {
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

}