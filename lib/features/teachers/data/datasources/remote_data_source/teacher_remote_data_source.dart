import 'package:dartz/dartz.dart';
import 'package:learny_project/features/teachers/data/models/techers_model.dart';
import '../../models/become_a_teacher_model.dart';

import '../../models/teacher_model.dart';
import '../../models/teacher_request_details_model.dart';
import '../../models/teachers_requests_model.dart';

abstract class TeacherRemoteDataSource{
Future<Unit> orderBecomeATeacher({required BecomeATeacherModel becomeATeacherModel});
Future<TeacherRequestDetailsModel> requestDetails({required int teacherId});
Future<String>acceptOrRejectRequestTeacher({required String statusId,required String teacherId});
Future<List<TeacherRequestsModel>> getAllRequestsTeachers({required List<String> statuses});
Future<TeachersModel>getTeachers({required List<String>languages,required int page});
Future<TeacherModel>getTeacher({required int teacherId});
}