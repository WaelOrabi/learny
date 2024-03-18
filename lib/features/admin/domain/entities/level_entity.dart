import 'package:equatable/equatable.dart';

class Level extends Equatable{
  String levelId;
  String levelName;
  String? levelDescription;
  Level({required this.levelId,required this.levelName ,this .levelDescription});

  @override
  List<Object?> get props => [levelId,levelName,levelDescription];

}