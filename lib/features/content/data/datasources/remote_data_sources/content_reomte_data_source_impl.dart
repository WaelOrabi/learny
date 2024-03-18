import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:learny_project/features/admin/data/models/language_model.dart';
import 'package:learny_project/features/content/data/models/all_paragraphs_model.dart';
import 'package:learny_project/features/content/data/models/all_posts_model.dart';
import 'package:learny_project/features/content/data/models/category_paragraph_model.dart';
import 'package:learny_project/features/content/data/models/category_question_model.dart';
import 'package:learny_project/features/content/data/models/level_content_model.dart';
import 'package:learny_project/features/content/data/models/paragraphs_model.dart';
import 'package:learny_project/features/content/data/models/posts_model.dart';
import 'package:learny_project/features/content/data/models/queations_model.dart';
import 'package:learny_project/features/content/data/models/type_posts_model.dart';
import 'package:learny_project/features/content/domain/entities/paragraphs_entity.dart';
import 'package:learny_project/features/content/domain/entities/posts_entity.dart';
import 'package:learny_project/features/content/domain/entities/questions_entity.dart';
import 'package:learny_project/features/teachers/data/models/techers_model.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/strings/api_end_point.dart';
import '../../../../auth/data/datasources/local_data_sources/auth_local_data_sources.dart';
import '../../../../auth/data/datasources/remote_data_sources/helper_function_auth_remote_data_sourcess.dart';
import '../../../../auth/data/models/user_model.dart';
import '../../models/all_questions_model.dart';
import 'content_remote_data_source.dart';

class ContentRemoteDateSourceImpl implements ContentRemoteDataSource {
  final AuthLocalDataSources authLocalDataSources;
  late final Dio dio;

  ContentRemoteDateSourceImpl({required this.authLocalDataSources}) {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: BASE_URL,
      receiveDataWhenStatusError: true,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'lang': 'en'
      },
    );
    dio = Dio(baseOptions);
  }

  @override
  Future<Unit> followOrUnFollow({required String teacherId}) async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});

    try {
      final response =
          await dio.post(FOLLOW_OR_UNFOLLOW, data: {"teacher_id": teacherId});
      if (response.statusCode == 200) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<TeachersModel> getAllFollowers() async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});

    try {
      final response = await dio.get(GET_ALL_FOLLOWERS);
      final TeachersModel teachers = TeachersModel.fromJson(response.data);
      return teachers;
    } on DioException catch (error) {
      handleDioError(error);
    } catch (error) {
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<Unit> createParagraph(
      {required ParagraphsEntity paragraphsEntity}) async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});
    ParagraphsModel paragraphsModel = ParagraphsModel(
        teacherId: paragraphsEntity.teacherId,
        firstNameTeacher: paragraphsEntity.firstNameTeacher,
        lastNameTeacher: paragraphsEntity.lastNameTeacher,
        languageParagraph: paragraphsEntity.languageParagraph,
        isFollowingTeacher: paragraphsEntity.isFollowingTeacher,
        level: paragraphsEntity.level,
        paragraphId: paragraphsEntity.paragraphId,
        paragraphName: paragraphsEntity.paragraphName,
        categoryParagraph: paragraphsEntity.categoryParagraph);

    try {
      final response =
          await dio.post(CREATE_PARAGRAPH, data: paragraphsModel.toJson());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<Unit> createQuestion(
      {required QuestionsEntity questionsEntity}) async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});

    QuestionsModel questionsModel = QuestionsModel(
        firstNameTeacher: questionsEntity.firstNameTeacher,
        lastNameTeacher: questionsEntity.lastNameTeacher,
        languagesTeacher: questionsEntity.languagesTeacher,
        isFollowingTeacher: questionsEntity.isFollowingTeacher,
        level: questionsEntity.level,
        questionId: questionsEntity.questionId,
        questionName: questionsEntity.questionName,
        descriptionAnswer: questionsEntity.descriptionAnswer,
        categoryQuestion: questionsEntity.categoryQuestion,
        optionsList: questionsEntity.optionsList, teacherId: questionsEntity.teacherId, isSolve: questionsEntity.isSolve);
print(questionsModel);
    try {
      final response =
          await dio.post(CREATE_QUESTION, data: questionsModel.toJson());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<Unit> deleteParagraph({required String paragraphId}) async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});

    try {
      final response = await dio.get("$DELETE_PARAGRAPH$paragraphId");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<Unit> deleteQuestion({required String questionId}) async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});
    try {
      final response = await dio.delete("$DELETE_QUESTION$questionId");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<AllParagraphsModel> getAllParagraphs(
      {required String pageId,
      required String languageId,
      required String categoryId,
      required String paragraphLevelId}) async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});

    try {
      final response = await dio.get(GET_ALL_PARAGRAPHS, queryParameters: {
        "language_id": languageId,
        "page": pageId,
        "category_id": categoryId,
        "content_level_Id": paragraphLevelId
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        late AllParagraphsModel allParagraphsModel;
        if(response.data["data"].toString()!="[]") {
          allParagraphsModel=AllParagraphsModel.fromJson(response.data);
        }else{
          allParagraphsModel=AllParagraphsModel(pages: PagesPage(currentPage: "0",lastPage: "0"), paragraphsEntity: []);
        }

        return Future.value(allParagraphsModel);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<AllQuestionsModel> getAllQuestions(
      {required String pageId,
      required String languageId,
      required String categoryId,
      required String questionLevelId}) async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});

    try {
      final response = await dio.get(GET_ALL_QUESTIONS, queryParameters: {
        "language_id": languageId,
        "page": pageId,
        "category_id": categoryId,
        "content_level_Id": questionLevelId
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        late AllQuestionsModel allQuestionsModel;
        if(response.data["data"].toString()!="[]") {
           allQuestionsModel=AllQuestionsModel.fromJson(response.data);
        }else{
          allQuestionsModel=AllQuestionsModel(pages: PagesPage(currentPage: "0",lastPage: "0"), questionsEntity: []);
        }

       return Future.value(allQuestionsModel);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<List<CategoryParagraphModel>> getCategoryParagraph() async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});

    try {
      final response = await dio.get(GET_CATEGOTY_PARAGRAPH);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<CategoryParagraphModel> list = [];
        for (int i = 0; i < response.data['data'].length; i++) {
          list.add(CategoryParagraphModel.fromJson(response.data['data'][i]));
        }

        return Future.value(list);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<List<CategoryQuestionModel>> getCategoryQuestion() async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});
    try {
      final response = await dio.get(GET_CATEGOTY_Question);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<CategoryQuestionModel> list = [];
        for (int i = 0; i < response.data['data'].length; i++) {
          list.add(CategoryQuestionModel.fromJson(response.data['data'][i]));
        }
        return Future.value(list);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<List<LevelContentModel>> getLevelContent() async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});

    try {
      final response = await dio.get(GET_LEVEL_CONTENT);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<LevelContentModel> list = [];
        for (int i = 0; i < response.data['data'].length; i++) {
          list.add(LevelContentModel.fromJson(response.data['data'][i]));
        }
        return Future.value(list);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<List<LanguageModel>> getMyLanguages() async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});

    try {
      final response = await dio.get(GET_MY_LANGUAGE);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<LanguageModel> list =
            response.data["data"].map((e) => LanguageModel.fromJson(e));
        return Future.value(list);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<AllParagraphsModel> getMyParagraphs(
      {required String pageId,
      required String languageId,
      required String categoryId,
      required String paragraphLevelId}) async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});

    try {
      final response = await dio.get(GET_MY_PARAGRAPH, queryParameters: {
        "language_id": languageId,
        "page": pageId,
        "category_id": categoryId,
        "content_level_Id": paragraphLevelId
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        late AllParagraphsModel allParagraphsModel;
        if(response.data["data"].toString()!="[]") {
          allParagraphsModel=AllParagraphsModel.fromJson(response.data);
        }else{
          allParagraphsModel=AllParagraphsModel(pages: PagesPage(currentPage: "0",lastPage: "0"), paragraphsEntity: []);
        }

        return Future.value(allParagraphsModel);

      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<AllQuestionsModel> getMyQuestions(
      {required String pageId,
      required String languageId,
      required String categoryId,
      required String questionLevelId}) async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});

    try {
      final response = await dio.get(GET_MY_QUESTION, queryParameters: {
        "language_id": languageId,
        "page": pageId,
        "category_id": categoryId,
        "content_level_Id": questionLevelId
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        late AllQuestionsModel allQuestionsModel;
        if(response.data["data"].toString()!="[]") {
          allQuestionsModel=AllQuestionsModel.fromJson(response.data);
        }else{
          allQuestionsModel=AllQuestionsModel(pages: PagesPage(currentPage: "0",lastPage: "0"), questionsEntity: []);
        }

        return Future.value(allQuestionsModel);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<ParagraphsModel> getParagraph({required String paragraphId}) async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});

    try {
      final response = await dio.get(
        "$GET_PARAGRAPH$paragraphId",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        ParagraphsModel paragraphsModel =
            ParagraphsModel.fromJson(response.data["data"]);
        return Future.value(paragraphsModel);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<QuestionsModel> getQuestion({required String questionId}) async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});

    try {
      final response = await dio.get("$GET_QUESTION$questionId");
      if (response.statusCode == 200 || response.statusCode == 201) {
        QuestionsModel questionsModel =
            QuestionsModel.fromJson(response.data["data"]);
        return Future.value(questionsModel);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<Unit> solveQuestion(
      {required String questionId, required String answerId}) async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});

    try {
      final response = await dio.post(SOLVE_QUESTION,
          data: {"question_id": questionId, "answer_id": answerId});
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<Unit> updateParagraph(
      {required ParagraphsEntity paragraphsEntity}) async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});

    ParagraphsModel paragraphsModel = ParagraphsModel(
        teacherId: paragraphsEntity.teacherId,
        firstNameTeacher: paragraphsEntity.firstNameTeacher,
        lastNameTeacher: paragraphsEntity.lastNameTeacher,
        languageParagraph: paragraphsEntity.languageParagraph,
        isFollowingTeacher: paragraphsEntity.isFollowingTeacher,
        level: paragraphsEntity.level,
        paragraphId: paragraphsEntity.paragraphId,
        paragraphName: paragraphsEntity.paragraphName,
        categoryParagraph: paragraphsEntity.categoryParagraph);

    try {
      final response =
          await dio.post(UPDATE_PARAGRAPH, data: paragraphsModel.toJson());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<Unit> updateQuestion(
      {required QuestionsEntity questionsEntity}) async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});

    QuestionsModel questionsModel = QuestionsModel(
        firstNameTeacher: questionsEntity.firstNameTeacher,
        lastNameTeacher: questionsEntity.lastNameTeacher,
        languagesTeacher: questionsEntity.languagesTeacher,
        isFollowingTeacher: questionsEntity.isFollowingTeacher,
        level: questionsEntity.level,
        questionId: questionsEntity.questionId,
        questionName: questionsEntity.questionName,
        categoryQuestion: questionsEntity.categoryQuestion,
        optionsList: questionsEntity.optionsList, teacherId: questionsEntity.teacherId, isSolve: questionsEntity.isSolve);

    try {
      final response =
          await dio.post(UPDATE_QUESTION, data: questionsModel.toJson());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<List<TypePostsModel>> getTypePosts() async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});

    try {
      final response =
      await dio.get(GET_TYPE_POSTS);
      if (response.statusCode == 200 || response.statusCode == 201) {

        List<TypePostsModel> list = [];
        for (int i = 0; i < response.data['data'].length; i++) {
          list.add(TypePostsModel.fromJson(response.data['data'][i]));
        }


        return Future.value(list);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<Unit> createPost({required PostsEntity postsEntity}) async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});
PostsModel postsModel=PostsModel(
    firstNameTeacher: postsEntity.firstNameTeacher,
    lastNameTeacher: postsEntity.lastNameTeacher,
    languagesTeacher: postsEntity.languagesTeacher,
    isFollowingTeacher: postsEntity.isFollowingTeacher,
    level: postsEntity.level,
    postId: postsEntity.postId,
    postName: postsEntity.postName,
    postTitle: postsEntity.postTitle,
    description: postsEntity.description,
    typePostsEntity: postsEntity.typePostsEntity, timePost: postsEntity.timePost,teacherId: postsEntity.teacherId);
    try {
      final response =
      await dio.post(CREATE_POST,data: postsModel.toJson());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<Unit> deletePost({required String postId}) async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});

    try {
      final response =
      await dio.get("$DELETE_POST$postId");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<AllPostsModel> getAllPosts({required String pageId, required String languageId, required String typeId, required String postLevelId})async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});

    try {
      final response =
      await dio.get(GET_ALL_POSTS,queryParameters: {
        "language_id": languageId,
        "page": pageId,
        "type_id": typeId,
        "content_level_Id": postLevelId
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        late AllPostsModel allPostsModel;
        if(response.data["data"].toString()!="[]") {
          allPostsModel=AllPostsModel.fromJson(response.data);
        }else{
          allPostsModel=AllPostsModel(pages: PagesPage(currentPage: "0",lastPage: "0"), postsEntity: []);
        }

        return Future.value(allPostsModel);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<List<PostsModel>> getMyPosts({required String pageId, required String languageId, required String typeId,required String postLevelId})async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});

    try {
      final response =
      await dio.get(GET_MY_POSTS,queryParameters: {
        "language_id": languageId,
        "page": pageId,
        "type_id": typeId,
        "content_level_Id": postLevelId
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<PostsModel> list=response.data["data"].map((e)=>PostsModel.fromJson(e));
        return Future.value(list);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<PostsModel> getPost({required String postId}) async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});

    try {
      final response =
      await dio.get("$GET_POST$postId");
      if (response.statusCode == 200 || response.statusCode == 201) {
        PostsModel postsModel=PostsModel.fromJson(response.data["data"]);
        return Future.value(postsModel);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }
}
