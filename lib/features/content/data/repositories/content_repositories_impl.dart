import 'package:dartz/dartz.dart';
import 'package:learny_project/features/admin/domain/entities/language_entity.dart';
import 'package:learny_project/features/content/domain/entities/all_paragraphs_entity.dart';
import 'package:learny_project/features/content/domain/entities/all_questions_entity.dart';
import 'package:learny_project/features/content/domain/entities/category_paragraph.dart';
import 'package:learny_project/features/content/domain/entities/category_question.dart';
import 'package:learny_project/features/content/domain/entities/level_content.dart';
import 'package:learny_project/features/content/domain/entities/paragraphs_entity.dart';
import 'package:learny_project/features/content/domain/entities/posts_entity.dart';
import 'package:learny_project/features/content/domain/entities/questions_entity.dart';
import 'package:learny_project/features/content/domain/entities/type_posts_entity.dart';
import 'package:learny_project/features/teachers/domain/entities/teachers_entity.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/all_posts_entity.dart';
import '../../domain/repositories/content_repository.dart';
import '../datasources/remote_data_sources/content_remote_data_source.dart';
import '../../../../core/error/exception.dart';

class ContentRepositoryImpl implements ContentRepository {
  final NetworkInfo networkInfo;
  final ContentRemoteDataSource contentRemoteDataSource;

  ContentRepositoryImpl(
      {required this.networkInfo, required this.contentRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> followOrUnFollow(
      {required String teacherId}) async {
    if (await networkInfo.isConnected) {
      try {
        await contentRemoteDataSource.followOrUnFollow(teacherId: teacherId);
        return const Right(unit);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, TeachersEntity>> getAllFollowers() async {
    if (await networkInfo.isConnected) {
      try {
        TeachersEntity result = await contentRemoteDataSource.getAllFollowers();
        return Right(result);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> createParagraph(
      {required ParagraphsEntity paragraphsEntity}) async {
    if (await networkInfo.isConnected) {
      try {
        await contentRemoteDataSource.createParagraph(
            paragraphsEntity: paragraphsEntity);
        return const Right(unit);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> createQuestion(
      {required QuestionsEntity questionsEntity}) async {
    if (await networkInfo.isConnected) {
      try {
        await contentRemoteDataSource.createQuestion(
            questionsEntity: questionsEntity);
        return const Right(unit);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteParagraph(
      {required String paragraphId}) async {
    if (await networkInfo.isConnected) {
      try {
        await contentRemoteDataSource.deleteParagraph(paragraphId: paragraphId);
        return const Right(unit);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteQuestion(
      {required String questionId}) async {
    if (await networkInfo.isConnected) {
      try {
        await contentRemoteDataSource.deleteQuestion(questionId: questionId);
        return const Right(unit);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, AllParagraphsEntity>> getAllParagraphs(
      {required String pageId,
      required String languageId,
      required String categoryId,
      required String paragraphLevelId}) async {
    if (await networkInfo.isConnected) {
      try {
        AllParagraphsEntity result =
            await contentRemoteDataSource.getAllParagraphs(
                pageId: pageId,
                languageId: languageId,
                categoryId: categoryId,
                paragraphLevelId: paragraphLevelId);
        return Right(result);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure,AllQuestionsEntity>> getAllQuestions(
      {required String pageId,
      required String languageId,
      required String categoryId,
      required String questionLevelId}) async {
    if (await networkInfo.isConnected) {
      try {
       AllQuestionsEntity result =
            await contentRemoteDataSource.getAllQuestions(
                pageId: pageId,
                languageId: languageId,
                categoryId: categoryId,
                questionLevelId: questionLevelId);
        return Right(result);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }


  @override
  Future<Either<Failure, List<CategoryParagraphEntity>>> getCategoryParagraph() async {
    if (await networkInfo.isConnected) {
      try {
        List<CategoryParagraphEntity> result =
        await contentRemoteDataSource.getCategoryParagraph();
        return Right(result);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }


  @override
  Future<Either<Failure, List<CategoryQuestionEntity>>> getCategoryQuestion() async {
    if (await networkInfo.isConnected) {
      try {
        List<CategoryQuestionEntity> result =
            await contentRemoteDataSource.getCategoryQuestion();
        return Right(result);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, List<LevelContentEntity>>> getLevelContent() async {
    if (await networkInfo.isConnected) {
      try {
        List<LevelContentEntity> result =
            await contentRemoteDataSource.getLevelContent();
        return Right(result);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Language>>> getMyLanguages() async {
    if (await networkInfo.isConnected) {
      try {
        List<Language> result = await contentRemoteDataSource.getMyLanguages();
        return Right(result);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, AllParagraphsEntity>> getMyParagraphs(
      {required String pageId,
      required String languageId,
      required String categoryId,
      required String paragraphLevelId}) async {
    if (await networkInfo.isConnected) {
      try {
        AllParagraphsEntity result =
            await contentRemoteDataSource.getMyParagraphs(
                pageId: pageId,
                languageId: languageId,
                categoryId: categoryId,
                paragraphLevelId: paragraphLevelId);
        return Right(result);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, AllQuestionsEntity>> getMyQuestions(
      {required String pageId,
      required String languageId,
      required String categoryId,
      required String questionLevelId}) async {
    if (await networkInfo.isConnected) {
      try {
        AllQuestionsEntity result =
            await contentRemoteDataSource.getMyQuestions(
                pageId: pageId,
                languageId: languageId,
                categoryId: categoryId,
                questionLevelId: questionLevelId);
        return Right(result);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, ParagraphsEntity>> getParagraph(
      {required String paragraphId}) async {
    if (await networkInfo.isConnected) {
      try {
        ParagraphsEntity result = await contentRemoteDataSource.getParagraph(
            paragraphId: paragraphId);
        return Right(result);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, QuestionsEntity>> getQuestion(
      {required String questionId}) async {
    if (await networkInfo.isConnected) {
      try {
        QuestionsEntity result =
            await contentRemoteDataSource.getQuestion(questionId: questionId);
        return Right(result);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> solveQuestion(
      {required String questionId, required String answerId}) async {
    if (await networkInfo.isConnected) {
      try {
        await contentRemoteDataSource.solveQuestion(
            questionId: questionId, answerId: answerId);
        return const Right(unit);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateParagraph(
      {required ParagraphsEntity paragraphsEntity}) async {
    if (await networkInfo.isConnected) {
      try {
        await contentRemoteDataSource.updateParagraph(
            paragraphsEntity: paragraphsEntity);
        return const Right(unit);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateQuestion(
      {required QuestionsEntity questionsEntity}) async {
    if (await networkInfo.isConnected) {
      try {
        await contentRemoteDataSource.updateQuestion(
            questionsEntity: questionsEntity);
        return const Right(unit);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, List<TypePostsEntity>>> getTypePosts()async {
    if (await networkInfo.isConnected) {
      try {
       List<TypePostsEntity> list= await contentRemoteDataSource.getTypePosts();
        return Right(list);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> createPost({required PostsEntity postsEntity}) async {
    if (await networkInfo.isConnected) {
      try {
        await contentRemoteDataSource.createPost(postsEntity: postsEntity);
        return const Right(unit);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost({required String postId}) async {
    if (await networkInfo.isConnected) {
      try {
        await contentRemoteDataSource.deletePost(postId: postId);
        return Right(unit);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, AllPostsEntity>> getAllPosts({required String pageId, required String languageId, required String typeId, required String postLevelId}) async {
    if (await networkInfo.isConnected) {
      try {
        AllPostsEntity list=  await contentRemoteDataSource.getAllPosts(pageId: pageId, languageId: languageId, typeId: typeId, postLevelId: postLevelId);
        return Right(list);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, List<PostsEntity>>> getMyPosts({required String pageId, required String languageId, required String typeId, required String postLevelId}) async {
    if (await networkInfo.isConnected) {
      try {
        List<PostsEntity>list=  await contentRemoteDataSource.getMyPosts(pageId: pageId, languageId: languageId, typeId: typeId, postLevelId: postLevelId);
        return Right(list);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, PostsEntity>> getPost({required String postId}) async {
    if (await networkInfo.isConnected) {
      try {
        PostsEntity postsEntity=  await contentRemoteDataSource.getPost(postId: postId);
        return Right(postsEntity);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
