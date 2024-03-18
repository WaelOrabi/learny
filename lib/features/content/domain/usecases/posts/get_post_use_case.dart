import 'package:dartz/dartz.dart';
import 'package:learny_project/features/content/domain/entities/posts_entity.dart';
import 'package:learny_project/features/content/domain/entities/type_posts_entity.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/paragraphs_entity.dart';
import '../../repositories/content_repository.dart';

class GetPostUseCase{
  final ContentRepository contentRepository;

  GetPostUseCase({required this.contentRepository});
  Future<Either<Failure, PostsEntity>> call({required String postId})async{
    return await contentRepository.getPost(postId: postId);
  }
}