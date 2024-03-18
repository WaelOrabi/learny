import 'package:equatable/equatable.dart';

class LevelContentEntity extends Equatable {
  final String levelId;
  final String levelName;

  LevelContentEntity({required this.levelId, required this.levelName});

  @override
  // TODO: implement props
  List<Object?> get props => [levelId, levelName];
}
