import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../repositories/level_repository.dart';

class DeleteLevelUseCase{
  final LevelRepository repository;
  DeleteLevelUseCase(this.repository);
  Future<Either<Failure,Unit>> call({required String levelId})async{
    return await repository.deleteLevel(levelId:levelId );
  }

}