import 'package:dartz/dartz.dart';
import 'package:learny_project/features/content/domain/entities/posts_entity.dart';
import 'package:learny_project/features/content/domain/entities/type_posts_entity.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/paragraphs_entity.dart';
import '../../repositories/content_repository.dart';

class DeletePostUseCase{
  final ContentRepository contentRepository;

  DeletePostUseCase({required this.contentRepository});
  Future<Either<Failure, Unit>> call({required String postId})async{
    return await contentRepository.deletePost(postId: postId);
  }
}