import 'package:dartz/dartz.dart';
import 'package:learny_project/core/error/failure.dart';
import 'package:learny_project/features/teachers/domain/repositories/teacher_repository.dart';

import '../entities/teacher_entity.dart';

class GetTeacherUseCase{
  final TeacherRepository teacherRepository;

  GetTeacherUseCase({required this.teacherRepository});
  Future<Either<Failure,TeacherEntity>>call({required int teacherId})async{
    return await teacherRepository.getTeacher(teacherId: teacherId);
  }
}