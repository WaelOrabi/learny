import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/content_repository.dart';

class FollowOrUnFollowUseCase{
  final ContentRepository contentRepository;

  FollowOrUnFollowUseCase({required this.contentRepository});
  Future<Either<Failure,Unit>>call({required String teacherId})async{
    return await contentRepository.followOrUnFollow(teacherId: teacherId);
  }
}