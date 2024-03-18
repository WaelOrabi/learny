import 'package:dartz/dartz.dart';
import 'package:learny_project/features/admin/data/models/language_model.dart';
import 'package:learny_project/features/admin/domain/entities/language_entity.dart';
import 'package:learny_project/features/content/data/models/all_paragraphs_model.dart';
import 'package:learny_project/features/content/data/models/category_paragraph_model.dart';
import 'package:learny_project/features/content/data/models/category_question_model.dart';
import 'package:learny_project/features/content/data/models/paragraphs_model.dart';
import 'package:learny_project/features/content/data/models/posts_model.dart';
import 'package:learny_project/features/content/data/models/queations_model.dart';
import 'package:learny_project/features/teachers/data/models/techers_model.dart';

import '../../../../teachers/domain/entities/teachers_entity.dart';
import '../../../domain/entities/category_question.dart';
import '../../../domain/entities/level_content.dart';
import '../../../domain/entities/paragraphs_entity.dart';
import '../../../domain/entities/posts_entity.dart';
import '../../../domain/entities/questions_entity.dart';
import '../../models/all_posts_model.dart';
import '../../models/all_questions_model.dart';
import '../../models/level_content_model.dart';
import '../../models/type_posts_model.dart';

abstract class ContentRemoteDataSource{
  Future<Unit> followOrUnFollow({required String teacherId});
  Future<TeachersModel> getAllFollowers();
  Future<List<CategoryQuestionModel>> getCategoryQuestion();
  Future<List<CategoryParagraphModel>> getCategoryParagraph();
  Future<List<LevelContentModel>> getLevelContent();
  Future<List<LanguageModel>> getMyLanguages();
  Future<Unit> deleteQuestion({required String questionId});
  Future<QuestionsModel> getQuestion({required String questionId});
  Future<Unit> solveQuestion({  required String questionId, required String answerId});
  Future<AllQuestionsModel> getAllQuestions({required String pageId,
    required String languageId,
    required String categoryId,
    required String questionLevelId,});
  Future<AllQuestionsModel> getMyQuestions({required String pageId,
    required String languageId,
    required String categoryId,
    required String questionLevelId,});
  Future<Unit> createQuestion({required QuestionsEntity questionsEntity});
  Future<Unit> updateQuestion({required QuestionsEntity questionsEntity});
  Future<Unit> deleteParagraph({required String paragraphId});
  Future<ParagraphsModel> getParagraph({required String paragraphId});
  Future<AllParagraphsModel> getAllParagraphs({required String pageId,
    required String languageId,
    required String categoryId,
    required String paragraphLevelId,});
  Future<AllParagraphsModel> getMyParagraphs({required String pageId,
    required String languageId,
    required String categoryId,
    required String paragraphLevelId,});
  Future<Unit> createParagraph({required ParagraphsEntity paragraphsEntity});
  Future<Unit> updateParagraph({required ParagraphsEntity paragraphsEntity});
  Future<List<TypePostsModel>> getTypePosts();
  Future<AllPostsModel> getAllPosts({required String pageId,
    required String languageId,
    required String typeId,
    required String postLevelId,});
  Future<List<PostsModel>> getMyPosts({required String pageId,
    required String languageId,
    required String typeId,
    required String postLevelId,});
  Future<Unit> createPost({required PostsEntity postsEntity});
  Future<Unit> deletePost({required String postId});
  Future<PostsModel> getPost({required String postId});

}