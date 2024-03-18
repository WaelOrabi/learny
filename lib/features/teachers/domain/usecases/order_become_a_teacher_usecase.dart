import 'package:dartz/dartz.dart';
import '../entities/become_a_teacher_entity.dart';

import '../repositories/teacher_repository.dart';

import '../../../../core/error/failure.dart';

class OrderBecomeATeacherUseCase{
final TeacherRepository teacherRepository;

OrderBecomeATeacherUseCase(this.teacherRepository);
  Future<Either<Failure,Unit>>call({required BecomeATeacherEntity becomeATeacherEntity})async{
    return await teacherRepository.orderBecomeATeacher(becomeATeacherEntity: becomeATeacherEntity);
  }
}