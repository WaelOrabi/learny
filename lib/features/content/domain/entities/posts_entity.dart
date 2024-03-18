import 'package:equatable/equatable.dart';
import 'package:learny_project/features/admin/domain/entities/language_entity.dart';
import 'package:learny_project/features/content/domain/entities/level_content.dart';
import 'package:learny_project/features/content/domain/entities/type_posts_entity.dart';

class PostsEntity extends Equatable {
  String teacherId;
  String firstNameTeacher;
  String lastNameTeacher;
  Language languagesTeacher;
  String? profileImageTeacher;
  bool isFollowingTeacher;
  String timePost;
  LevelContentEntity level;
  String postId;
  String postName;
  String postTitle;
  String description;
  TypePostsEntity typePostsEntity;

  PostsEntity(
      {required this.teacherId,
        required this.firstNameTeacher,
      required this.lastNameTeacher,
      required this.languagesTeacher,
      this.profileImageTeacher,
      required this.timePost,
      required this.isFollowingTeacher,
      required this.level,
      required this.postId,
      required this.postName,
      required this.postTitle,
      required this.description,
      required this.typePostsEntity});

  @override
  List<Object?> get props => [
        firstNameTeacher,
        lastNameTeacher,
        profileImageTeacher,
        languagesTeacher,
        isFollowingTeacher,
        level,
        postTitle,
        postName,
        postId,
        timePost,
        description,
        typePostsEntity
      ];
}
