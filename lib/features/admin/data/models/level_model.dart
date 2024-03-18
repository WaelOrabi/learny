import '../../domain/entities/level_entity.dart';
class LevelModel extends Level{
  LevelModel({required super.levelId, required super.levelName,super.levelDescription});
  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
        levelId: json['id'].toString(),
        levelName: json['level_name'],
        levelDescription: json['level_description']??''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': levelId,
      'level_name': levelName,
      'level_description': levelDescription,
    };
  }
}