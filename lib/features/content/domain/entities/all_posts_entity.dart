import 'package:equatable/equatable.dart';
import 'package:learny_project/features/content/domain/entities/posts_entity.dart';
import 'package:learny_project/features/content/domain/entities/questions_entity.dart';

class AllPostsEntity extends Equatable{

  final PagesPage pages;
  final List<PostsEntity> postsEntity;

  AllPostsEntity({required this.pages,required this.postsEntity});
  
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}