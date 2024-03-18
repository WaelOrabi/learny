part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}
class AddVideoPostEvent extends PostsEvent {
  final String videoBase64;

  AddVideoPostEvent({required this.videoBase64});

}
class PickImagePostEvent extends PostsEvent {}


class GetTypePostsEvent extends PostsEvent{}

class DeletePostEvent extends PostsEvent{
  final String postId;
  DeletePostEvent({required this.postId});
}

class GetPostEvent extends PostsEvent{
  final String postId;
  GetPostEvent({required this.postId});
}


class GetAllPostsEvent extends PostsEvent{
  final String pageId;
  final String languageId;
  final String typeId;
  final String postLevelId;

  GetAllPostsEvent(
      {required this.pageId,required this.languageId,required  this.typeId,required this.postLevelId});

}

class GetMyPostsEvent extends PostsEvent{
  final String pageId;
  final String languageId;
  final String typeId;
  final String postLevelId;

  GetMyPostsEvent(
      {required this.pageId,required this.languageId,required  this.typeId,required this.postLevelId});

}

class CreatePostEvent extends PostsEvent{
  final PostsEntity postsEntity;
  CreatePostEvent({required this.postsEntity});
}

