import 'package:intl/intl.dart';
import 'package:learny_project/features/auth/data/models/user_model.dart';
import 'package:learny_project/features/teachers/domain/entities/teachers_requests.dart';

class TeacherRequestsModel extends TeachersRequestsEntity {
  const TeacherRequestsModel({
    required super.teacherId,
    required super.rating,
    required super.status,
    required super.userInfo,
    required super.createdAt,
  });

  factory TeacherRequestsModel.fromJson(Map<String, dynamic> json) {
    return TeacherRequestsModel(
      teacherId: json['teacher_id'],
      status: json['status'],
      rating: json['rating'],
      userInfo: UserModel.fromJson(json['user_info']),
      createdAt: json['created_at'],
    );
  }
}
