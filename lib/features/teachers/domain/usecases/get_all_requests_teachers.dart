import 'package:dartz/dartz.dart';
import 'package:learny_project/features/teachers/domain/entities/teachers_requests.dart';

import '../../../../core/error/failure.dart';
import '../repositories/teacher_repository.dart';

class GetAllRequestsTeachersUseCase{
  final TeacherRepository teacherRepository;

  GetAllRequestsTeachersUseCase(this.teacherRepository);
  Future<Either<Failure,List<TeachersRequestsEntity>>>call({required List<String> statuses})async{
    return await teacherRepository.getAllRequestsTeachers(statuses: statuses);
  }
}