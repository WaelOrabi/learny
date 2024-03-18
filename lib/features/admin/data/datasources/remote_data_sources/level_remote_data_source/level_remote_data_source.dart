import 'package:dartz/dartz.dart';
import '../../../models/level_model.dart';

abstract class LevelRemoteDataSource{
  Future<List<LevelModel>>getAllLevels();
  Future<Unit> addLevel({required String levelName,required String levelDescription});
  Future<Unit> deleteLevel({required String levelId});
}