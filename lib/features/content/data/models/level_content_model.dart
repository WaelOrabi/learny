import 'package:learny_project/features/content/domain/entities/level_content.dart';

class LevelContentModel extends LevelContentEntity{
  LevelContentModel({required super.levelId, required super.levelName});


  factory LevelContentModel.fromJson(Map <String,dynamic>json){
    return LevelContentModel(levelId: json['id'].toString(), levelName: json['level'].toString());
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = levelId;
    _data['level'] = levelName;

    return _data;
  }

}