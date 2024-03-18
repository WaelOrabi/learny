import 'package:dartz/dartz.dart';
import '../../data/models/teacher_request_details_model.dart';
import '../entities/teacher_request_details_entity.dart';
import '../repositories/teacher_repository.dart';

import '../../../../core/error/failure.dart';

class TeacherRequestDetailsUseCase{
   final TeacherRepository teacherRepository;

  TeacherRequestDetailsUseCase(this.teacherRepository);
Future<Either<Failure,TeacherRequestDetailsEntity>>call({required int teacherId})async{
  return await teacherRepository.requestDetails(teacherId: teacherId);
}
}