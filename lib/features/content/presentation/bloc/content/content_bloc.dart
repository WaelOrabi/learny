import 'package:bloc/bloc.dart';
import 'package:learny_project/features/admin/domain/entities/language_entity.dart';
import 'package:learny_project/features/content/domain/entities/category_question.dart';
import 'package:learny_project/features/content/domain/entities/level_content.dart';
import 'package:learny_project/features/content/domain/usecases/get_category_question_use_case.dart';
import 'package:learny_project/features/teachers/domain/entities/teachers_entity.dart';
import 'package:meta/meta.dart';

import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/entities/category_paragraph.dart';
import '../../../domain/usecases/follow_or_unfollow_use_case.dart';
import '../../../domain/usecases/get_all_followers_use_case.dart';
import '../../../domain/usecases/get_category_paragraph_use_case.dart';
import '../../../domain/usecases/get_level_content_use_case.dart';
import '../../../domain/usecases/get_my_languages_use_case.dart';
import '../../../domain/usecases/questions/solve_question_use_case.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
final FollowOrUnFollowUseCase followOrUnFollowUseCase;
final GetAllFollowersUseCase getAllFollowersUseCase;
final GetCategoryQuestionUseCase getCategoriesQuestionUseCase;
final GetCategoryParagraphUseCase getCategoryParagraphUseCase;
final GetLevelContentUseCase getLevelContentUseCase;
final GetMyLanguagesUseCase getMyLanguagesUseCase;
final SolveQuestionUseCase solveQuestionUseCase;
  ContentBloc({required this.solveQuestionUseCase,required this.getCategoriesQuestionUseCase,required this.getCategoryParagraphUseCase,required this.getLevelContentUseCase,required this.getMyLanguagesUseCase,  required this.followOrUnFollowUseCase,required this.getAllFollowersUseCase,}) : super(ContentInitial()) {
    on<ContentEvent>((event, emit) async{
      if(event is FollowOrUnFollowEvent){
        emit(FollowOrUnFollowLoadingState());
        final failureOrRequest = await followOrUnFollowUseCase(teacherId: event.teacherId);
        failureOrRequest.fold((failure) {
          emit(FollowOrUnFollowErrorState(message: mapFailureToMessage(failure)));
        }, (message) {
          emit(FollowOrUnFollowSuccessState());
        });

      }else if(event is GetAllFollowersEvent){
        emit(GetAllFollowersLoadingState());
        final failureOrRequest = await getAllFollowersUseCase();
        failureOrRequest.fold((failure) {
          emit(GetAllFollowersErrorState(message: mapFailureToMessage(failure)));
        }, (message) {
          emit(GetAllFollowersSuccessState(teachersEntity: message));
        });

      }else if(event is SolveQuestionEvent){
        emit(SolveQuestionLoading());
        final failureOrRequest = await solveQuestionUseCase(questionId: event.questionId,answerId: event.answerId);
        failureOrRequest.fold((failure) {
          emit(SolveQuestionError(message: mapFailureToMessage(failure)));
        }, (message) {
          emit(SolveQuestionSuccess());
        });
      }
      else if(event is GetCategoriesQuestionEvent){
        emit(GetCategoriesQuestionLoading());
        final failureOrRequest = await getCategoriesQuestionUseCase();
        failureOrRequest.fold((failure) {
          emit(GetCategoriesQuestionError(message: mapFailureToMessage(failure)));
        }, (message) {
          emit(GetCategoriesQuestionSuccess(listCategoryQuestionEntity: message));
        });
      }else if(event is GetCategoriesParagraphEvent){
        emit(GetCategoriesParagraphLoading());
        final failureOrRequest = await getCategoryParagraphUseCase();
        failureOrRequest.fold((failure) {
          emit(GetCategoriesParagraphError(message: mapFailureToMessage(failure)));
        }, (message) {
          emit(GetCategoriesParagraphSuccess(listCategoryParagraphEntity: message));
        });
      }else if(event is GetLevelsContentEvent){
        emit(GetLevelsContentLoading());
        final failureOrRequest = await getLevelContentUseCase();
        failureOrRequest.fold((failure) {
          emit(GetLevelsContentError(message: mapFailureToMessage(failure)));
        }, (message) {
          emit(GetLevelsContentSuccess(listLevelContentEntity: message));
        });
      }else if(event is GetMyLanguageEvent){
        emit(GetMyLanguagesLoading());
        final failureOrRequest = await getMyLanguagesUseCase();
        failureOrRequest.fold((failure) {
          emit(GetMyLanguagesError(message: mapFailureToMessage(failure)));
        }, (message) {
          emit(GetMyLanguagesSuccess(listLanguages: message));
        });
      }
    });
  }
}
