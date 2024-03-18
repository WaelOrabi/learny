part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}
class AddVideoPostState extends PostsState {
  final String videoBase64;

  AddVideoPostState({required this.videoBase64});
}

class ImagePickedPostState extends PostsState {
  final File imageFile;

  ImagePickedPostState({required this.imageFile});
}




class GetTypePostsLoading extends PostsState{}
class GetTypePostsError extends PostsState{
List<String>message;
GetTypePostsError({required this.message});
}
class GetTypePostsSuccess extends PostsState{
  final List<TypePostsEntity> listTypePosts;
  GetTypePostsSuccess({required this.listTypePosts});
}



class DeletePostLoading extends PostsState{}
class DeletePostError extends PostsState{
  List<String>message;
  DeletePostError({required this.message});
}
class DeletePostSuccess extends PostsState{}




class GetPostLoading extends PostsState{}
class GetPostError extends PostsState{
  List<String>message;
  GetPostError({required this.message});
}
class GetPostSuccess extends PostsState{
  final PostsEntity postsEntity;
  GetPostSuccess({required this.postsEntity});
}


class GetAllPostsLoading extends PostsState{}
class GetAllPostsError extends PostsState{
  List<String>message;
  GetAllPostsError({required this.message});
}
class GetAllPostsSuccess extends PostsState{
  final AllPostsEntity listPosts;
  GetAllPostsSuccess({required this.listPosts});
}




class GetMyPostsLoading extends PostsState{}
class GetMyPostsError extends PostsState{
  List<String>message;
  GetMyPostsError({required this.message});
}
class GetMyPostsSuccess extends PostsState{
  final List<PostsEntity> listPosts;
  GetMyPostsSuccess({required this.listPosts});
}



class CreatePostLoading extends PostsState{}
class CreatePostError extends PostsState{
  List<String>message;
  CreatePostError({required this.message});
}
class CreatePostSuccess extends PostsState{}




