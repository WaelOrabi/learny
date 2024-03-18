import 'package:dartz/dartz.dart';
import '../../entities/level_entity.dart';
import '../../../../../core/error/failure.dart';
import '../../repositories/level_repository.dart';

class GetAllLevelsUseCase{
  final LevelRepository repository;
  GetAllLevelsUseCase(this.repository);
  Future<Either<Failure,List<Level>>> call()async{
    return await repository.getAllLevels();
  }

}