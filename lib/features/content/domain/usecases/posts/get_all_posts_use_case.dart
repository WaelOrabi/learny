import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';

import '../../entities/all_posts_entity.dart';
import '../../repositories/content_repository.dart';

class GetAllPostsUseCase{
  final ContentRepository contentRepository;

  GetAllPostsUseCase({required this.contentRepository});
  Future<Either<Failure, AllPostsEntity>> call({required String pageId,
    required String languageId,
    required String typeId,
    required String postLevelId,})async{
    return await contentRepository.getAllPosts(pageId: pageId, languageId: languageId, typeId: typeId, postLevelId: postLevelId);
  }
}