import 'package:dartz/dartz.dart';
import 'package:learny_project/features/content/domain/entities/posts_entity.dart';
import 'package:learny_project/features/content/domain/entities/type_posts_entity.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/paragraphs_entity.dart';
import '../../repositories/content_repository.dart';

class GetMyPostsUseCase{
  final ContentRepository contentRepository;

  GetMyPostsUseCase({required this.contentRepository});
  Future<Either<Failure, List<PostsEntity>>> call({required String pageId,
    required String languageId,
    required String typeId,
    required String postLevelId,})async{
    return await contentRepository.getMyPosts(pageId: pageId, languageId: languageId, typeId: typeId, postLevelId: postLevelId);
  }
}