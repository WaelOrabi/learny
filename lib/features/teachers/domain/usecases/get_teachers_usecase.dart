import 'package:dartz/dartz.dart';
import 'package:learny_project/core/error/failure.dart';
import 'package:learny_project/features/teachers/domain/entities/teachers_entity.dart';
import 'package:learny_project/features/teachers/domain/repositories/teacher_repository.dart';

class GetTeachersUseCase{
  final TeacherRepository teacherRepository;

  GetTeachersUseCase({required this.teacherRepository});
 Future<Either<Failure, TeachersEntity>>call({required List<String>languages,required int numberPage})async{
    return  await teacherRepository.getTeachers(languages: languages, numberPage: numberPage);
  }

}