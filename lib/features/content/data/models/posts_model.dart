import 'package:learny_project/features/content/data/models/type_posts_model.dart';
import 'package:learny_project/features/content/domain/entities/posts_entity.dart';

import '../../../admin/domain/entities/language_entity.dart';
import 'level_content_model.dart';

class PostsModel extends PostsEntity {
  PostsModel(
      {required super.teacherId,
          required super.firstNameTeacher,
      required super.lastNameTeacher,
          super.profileImageTeacher,
          required super.timePost,
      required super.languagesTeacher,
      required super.isFollowingTeacher,
      required super.level,
      required super.postId,
      required super.postName,
      required super.postTitle,
      required super.description,
      required super.typePostsEntity});

factory PostsModel.fromJson(Map<String,dynamic>json){
    return PostsModel(
        teacherId: json["teacher"]["teacher_id"].toString(),
        firstNameTeacher: json['teacher']["user_info"]["first_name"].toString(),
        lastNameTeacher: json['teacher']["user_info"]["last_name"].toString(),
        profileImageTeacher: json['teacher']["user_info"]["personal_image"].toString(),
        languagesTeacher: Language(languageId: json["id"].toString(), languageName: json["language_name"].toString()),
        isFollowingTeacher: json["is_followed"],
        level: LevelContentModel.fromJson(json["content_levels"]),
        postId: json["id"].toString(),
        postName: json["files"][0]["file"].toString(),
        timePost:json["files"][0]["created_at"].toString() ,
        postTitle: json["title"].toString(),
        description: json["description"].toString(),
        typePostsEntity: TypePostsModel.fromJson(json["type"]));
}
  Map<String, dynamic> toJson() {
      final _data = <String, dynamic>{};
      _data['id'] = postId;
      _data['content_levels_id'] = level.levelId;
      _data['files[0]'] = postName;
      _data['description'] = description;
      _data['title'] = postTitle;
      _data['type_id'] = typePostsEntity.typeId;
      _data['language_id'] = languagesTeacher.languageId;
      return _data;
  }


}
