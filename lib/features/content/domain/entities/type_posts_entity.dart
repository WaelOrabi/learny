import 'package:equatable/equatable.dart';

class TypePostsEntity extends Equatable{
  final String typeId;
  final String typeName;

  TypePostsEntity({required this.typeId,required this.typeName});

  @override
  // TODO: implement props
  List<Object?> get props => [typeId,typeName];
}