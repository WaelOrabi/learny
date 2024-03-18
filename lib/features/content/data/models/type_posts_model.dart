import 'dart:convert';

import 'package:learny_project/features/content/domain/entities/type_posts_entity.dart';

class TypePostsModel extends TypePostsEntity{
  TypePostsModel({required super.typeId, required super.typeName});
  factory TypePostsModel.fromJson(Map<String,dynamic> json){
    return TypePostsModel(typeId: json["id"].toString(), typeName: json["type"].toString());
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = typeId;
    _data['type'] = typeName;
    return _data;
  }

}