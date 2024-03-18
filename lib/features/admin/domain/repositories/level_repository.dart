import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

import '../entities/level_entity.dart';

abstract class LevelRepository {
  Future<Either<Failure,List<Level>>> getAllLevels();
  Future<Either<Failure,Unit>> addLevel({required String levelName, required String levelDescription });
  Future<Either<Failure,Unit>> deleteLevel({required String levelId});
}
