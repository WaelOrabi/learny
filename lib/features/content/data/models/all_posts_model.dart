
import 'package:learny_project/features/content/data/models/posts_model.dart';
import 'package:learny_project/features/content/domain/entities/questions_entity.dart';

import '../../domain/entities/all_posts_entity.dart';


class AllPostsModel extends AllPostsEntity {
  AllPostsModel({required super.pages, required super.postsEntity});


  factory AllPostsModel.fromJson(Map<String, dynamic> json) {
    return AllPostsModel(
        pages: PagesPage(
            currentPage: json["meta"]["current_page"].toString(),
            lastPage: json["meta"]["last_page"].toString()),
        postsEntity: List<PostsModel>.from(
            json["data"].map((x) => PostsModel.fromJson(x))));
  }
}
