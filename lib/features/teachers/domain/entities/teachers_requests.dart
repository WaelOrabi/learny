import 'package:equatable/equatable.dart';

import '../../../auth/domain/entities/user_entity.dart';

class TeachersRequestsEntity extends Equatable {
  final int teacherId;
  final String status;
  final double rating;
  final UserEntity userInfo;
  final String createdAt;

  const TeachersRequestsEntity(
      {required this.teacherId,
      required this.rating,
      required this.status,
      required this.userInfo,
      required this.createdAt});

  @override
  // TODO: implement props
  List<Object?> get props => [teacherId, status, userInfo, createdAt];
}
