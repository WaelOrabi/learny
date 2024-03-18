import 'package:dartz/dartz.dart';
import 'package:learny_project/features/teachers/domain/entities/teachers_requests.dart';
import '../entities/become_a_teacher_entity.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/teacher_request_details_model.dart';
import '../entities/teacher_entity.dart';
import '../entities/teacher_request_details_entity.dart';
import '../entities/teachers_entity.dart';

abstract class TeacherRepository{
  Future<Either<Failure,TeacherRequestDetailsEntity>> requestDetails({required int teacherId});
  Future<Either<Failure,Unit>> orderBecomeATeacher({required BecomeATeacherEntity becomeATeacherEntity});
  Future<Either<Failure,List<TeachersRequestsEntity>>> getAllRequestsTeachers({required List<String> statuses});
  Future<Either<Failure,String>> acceptOrRejectRequestTeacher({required String teacherId,required String statusId});
  Future<Either<Failure,TeachersEntity>>getTeachers({required List<String>languages,required int numberPage});
  Future<Either<Failure,TeacherEntity>>getTeacher({required int teacherId});
}

