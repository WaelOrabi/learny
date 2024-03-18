import 'package:dartz/dartz.dart';
import 'package:learny_project/features/content/domain/entities/posts_entity.dart';
import 'package:learny_project/features/content/domain/entities/type_posts_entity.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/paragraphs_entity.dart';
import '../../repositories/content_repository.dart';

class CreatePostUseCase{
  final ContentRepository contentRepository;

  CreatePostUseCase({required this.contentRepository});
  Future<Either<Failure, Unit>> call({required PostsEntity postsEntity})async{
    return await contentRepository.createPost(postsEntity: postsEntity);
  }
}