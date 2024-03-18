import 'package:dartz/dartz.dart';
import 'package:learny_project/features/teachers/domain/repositories/teacher_repository.dart';

import '../../../../core/error/failure.dart';

class AcceptOrRejectRequestTeacher{
  final TeacherRepository teacherRepository;

  AcceptOrRejectRequestTeacher({required this.teacherRepository});
  Future<Either<Failure,String>>call({required String statusId,required String teacherId})async{
    return await teacherRepository.acceptOrRejectRequestTeacher(teacherId: teacherId, statusId: statusId);
  }
}