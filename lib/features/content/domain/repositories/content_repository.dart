import 'package:dartz/dartz.dart';
import 'package:learny_project/features/content/data/models/all_paragraphs_model.dart';
import 'package:learny_project/features/content/domain/entities/category_paragraph.dart';
import 'package:learny_project/features/content/domain/entities/posts_entity.dart';
import 'package:learny_project/features/content/domain/entities/type_posts_entity.dart';
import 'package:learny_project/features/teachers/domain/entities/teachers_entity.dart';

import '../../../../core/error/failure.dart';
import '../../../admin/domain/entities/language_entity.dart';
import '../entities/all_paragraphs_entity.dart';
import '../entities/all_posts_entity.dart';
import '../entities/all_questions_entity.dart';
import '../entities/category_question.dart';
import '../entities/level_content.dart';
import '../entities/paragraphs_entity.dart';
import '../entities/questions_entity.dart';


abstract class ContentRepository{
  Future<Either<Failure,Unit>> followOrUnFollow({required String teacherId});
  Future<Either<Failure,TeachersEntity>> getAllFollowers();
  Future<Either<Failure,List<CategoryQuestionEntity>>> getCategoryQuestion();
  Future<Either<Failure,List<CategoryParagraphEntity>>> getCategoryParagraph();
  Future<Either<Failure,List<LevelContentEntity>>> getLevelContent();
  Future<Either<Failure,List<Language>>> getMyLanguages();
  Future<Either<Failure,Unit>> deleteQuestion({required String questionId});
  Future<Either<Failure,QuestionsEntity>> getQuestion({required String questionId});
  Future<Either<Failure,Unit>> solveQuestion({  required String questionId, required String answerId});
  Future<Either<Failure,AllQuestionsEntity>> getAllQuestions({required String pageId,
  required String languageId,
  required String categoryId,
  required String questionLevelId,});
  Future<Either<Failure,AllQuestionsEntity>> getMyQuestions({required String pageId,
    required String languageId,
    required String categoryId,
    required String questionLevelId,});
  Future<Either<Failure,Unit>> createQuestion({required QuestionsEntity questionsEntity});
  Future<Either<Failure,Unit>> updateQuestion({required QuestionsEntity questionsEntity});
  Future<Either<Failure,Unit>> deleteParagraph({required String paragraphId});
  Future<Either<Failure,ParagraphsEntity>> getParagraph({required String paragraphId});
  Future<Either<Failure,AllParagraphsEntity>> getAllParagraphs({required String pageId,
    required String languageId,
    required String categoryId,
    required String paragraphLevelId,});
  Future<Either<Failure,AllParagraphsEntity>> getMyParagraphs({required String pageId,
    required String languageId,
    required String categoryId,
    required String paragraphLevelId,});
  Future<Either<Failure,Unit>> createParagraph({required ParagraphsEntity paragraphsEntity});
  Future<Either<Failure,Unit>> updateParagraph({required ParagraphsEntity paragraphsEntity});

  Future<Either<Failure,List<TypePostsEntity>>> getTypePosts();
  Future<Either<Failure,AllPostsEntity>> getAllPosts({required String pageId,
    required String languageId,
    required String typeId,
    required String postLevelId,});
  Future<Either<Failure,List<PostsEntity>>> getMyPosts({required String pageId,
    required String languageId,
    required String typeId,
    required String postLevelId,});
  Future<Either<Failure,Unit>> createPost({required PostsEntity postsEntity});
  Future<Either<Failure,Unit>> deletePost({required String postId});
  Future<Either<Failure,PostsEntity>> getPost({required String postId});




}

