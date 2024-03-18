import 'package:dartz/dartz.dart';
import 'package:learny_project/features/content/domain/entities/type_posts_entity.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/paragraphs_entity.dart';
import '../../repositories/content_repository.dart';

class GetTypePostsUseCase{
  final ContentRepository contentRepository;

  GetTypePostsUseCase({required this.contentRepository});
  Future<Either<Failure, List<TypePostsEntity>>> call()async{
    return await contentRepository.getTypePosts();
  }
}