import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../repositories/level_repository.dart';

class AddLevelUseCase{
  final LevelRepository repository;
  AddLevelUseCase(this.repository);
  Future<Either<Failure,Unit>> call({required String levelName,required String levelDescription})async{
    return await repository.addLevel(levelName: levelName,levelDescription:levelDescription);
  }

}