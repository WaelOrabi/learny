import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learny_project/features/content/domain/entities/type_posts_entity.dart';
import 'package:learny_project/features/content/domain/usecases/posts/create_post_use_case.dart';
import 'package:learny_project/features/content/domain/usecases/posts/delete_post_use_case.dart';
import 'package:meta/meta.dart';

import '../../../../auth/presentation/widgets/map_failure_to_message.dart';
import '../../../domain/entities/all_posts_entity.dart';
import '../../../domain/entities/posts_entity.dart';
import '../../../domain/usecases/posts/get_all_posts_use_case.dart';
import '../../../domain/usecases/posts/get_my_posts_use_case.dart';
import '../../../domain/usecases/posts/get_post_use_case.dart';
import '../../../domain/usecases/posts/get_type_posts_use_case.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  String videoBase64 = '';
  XFile? imagePost = null;
  String imageBase64 = "";
  String pdfBase64 = "";

  final GetTypePostsUseCase getTypePostsUseCase;
  final CreatePostUseCase createPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final GetAllPostsUseCase getAllPostsUseCase;
  final GetMyPostsUseCase getMyPostsUseCase;
  final GetPostUseCase getPostUseCase;

  PostsBloc({
    required this.getTypePostsUseCase,
    required this.createPostUseCase,
    required this.deletePostUseCase,
    required this.getAllPostsUseCase,
    required this.getMyPostsUseCase,
    required this.getPostUseCase,
  }) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is AddVideoPostEvent) {
        videoBase64 = event.videoBase64;
        emit(AddVideoPostState(videoBase64: videoBase64));
      } else if (event is PickImagePostEvent) {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          imagePost = pickedFile;
          emit(ImagePickedPostState(imageFile: File(imagePost!.path)));
        }
      } else if (event is GetTypePostsEvent) {
        emit(GetTypePostsLoading());
        final failureOrRequest = await getTypePostsUseCase();
        failureOrRequest.fold((failure) {
          emit(GetTypePostsError(message: mapFailureToMessage(failure)));
        }, (message) {
          emit(GetTypePostsSuccess(listTypePosts: message));
        });
      } else if (event is DeletePostEvent) {
        emit(DeletePostLoading());
        final failureOrRequest = await deletePostUseCase(postId: event.postId);
        failureOrRequest.fold((failure) {
          emit(DeletePostError(message: mapFailureToMessage(failure)));
        }, (message) {
          emit(DeletePostSuccess());
        });
      } else if (event is GetPostEvent) {
        emit(GetPostLoading());
        final failureOrRequest = await getPostUseCase(postId: event.postId);
        failureOrRequest.fold((failure) {
          emit(GetPostError(message: mapFailureToMessage(failure)));
        }, (message) {
          emit(GetPostSuccess(postsEntity: message));
        });
      } else if (event is GetAllPostsEvent) {
        emit(GetAllPostsLoading());
        final failureOrRequest = await getAllPostsUseCase(
            pageId: event.pageId,
            postLevelId: event.postLevelId,
            languageId: event.languageId,
            typeId: event.typeId);
        failureOrRequest.fold((failure) {
          emit(GetAllPostsError(message: mapFailureToMessage(failure)));
        }, (message) {
          emit(GetAllPostsSuccess(listPosts: message));
        });
      } else if (event is GetMyPostsEvent) {
        emit(GetMyPostsLoading());
        final failureOrRequest = await getMyPostsUseCase(
            pageId: event.pageId,
            typeId: event.typeId,
            languageId: event.languageId,
            postLevelId: event.postLevelId);
        failureOrRequest.fold((failure) {
          emit(GetMyPostsError(message: mapFailureToMessage(failure)));
        }, (message) {
          emit(GetMyPostsSuccess(listPosts: message));
        });
      } else if (event is CreatePostEvent) {
        emit(CreatePostLoading());
        final failureOrRequest =
            await createPostUseCase(postsEntity: event.postsEntity);
        failureOrRequest.fold((failure) {
          emit(CreatePostError(message: mapFailureToMessage(failure)));
        }, (message) {
          emit(CreatePostSuccess());
        });
      }
    });
  }
}
