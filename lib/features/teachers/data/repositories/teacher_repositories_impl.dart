import 'package:dartz/dartz.dart';
import 'package:learny_project/features/teachers/domain/entities/teachers_requests.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/teacher_entity.dart';
import '../../domain/entities/teacher_request_details_entity.dart';
import '../../domain/entities/teachers_entity.dart';
import '../models/become_a_teacher_model.dart';
import '../../domain/entities/become_a_teacher_entity.dart';
import '../../domain/repositories/teacher_repository.dart';
import '../../../../core/error/exception.dart';
import '../datasources/remote_data_source/teacher_remote_data_source.dart';
import '../models/teacher_request_details_model.dart';

class TeacherRepositoryImpl implements TeacherRepository{
  final NetworkInfo networkInfo;
final TeacherRemoteDataSource teacherRemoteDataSource;
  TeacherRepositoryImpl({required this.networkInfo,required this.teacherRemoteDataSource});


  @override
  Future<Either<Failure, Unit>> orderBecomeATeacher({required BecomeATeacherEntity becomeATeacherEntity}) async{
    final BecomeATeacherModel becomeATeacherModel = BecomeATeacherModel(
        infoBecomeATeacher:becomeATeacherEntity.infoBecomeATeacher,
        cardBecomeATeacher: becomeATeacherEntity.cardBecomeATeacher,
        listLanguageBecomeATeacher: becomeATeacherEntity.listLanguageBecomeATeacher);

    if (await networkInfo.isConnected) {
      try {
         await teacherRemoteDataSource.orderBecomeATeacher(becomeATeacherModel: becomeATeacherModel);
        return const Right(unit);
      } catch (error) {
        print(error);
        if (error is WrongDataException) {
          print(error.messages);
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }
  @override
  Future<Either<Failure, TeacherRequestDetailsEntity>> requestDetails({required int teacherId})async {
    if(await networkInfo.isConnected){
      try{
        final requestDetails = await teacherRemoteDataSource.requestDetails(
            teacherId: teacherId);
        return Right(requestDetails);
      }on ServerException{
        return Left(ServerFailure());
      }
    }
    else{
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, List<TeachersRequestsEntity>>> getAllRequestsTeachers({required List<String> statuses}) async{
    if(await networkInfo.isConnected){
      try{
        final teachersRequests = await teacherRemoteDataSource.getAllRequestsTeachers(statuses: statuses);
        return Right(teachersRequests);
      }on ServerException{
        return Left(ServerFailure());
      }
    }
    else{
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, String>> acceptOrRejectRequestTeacher({required String teacherId, required String statusId}) async{
   if(await networkInfo.isConnected){
     try{
       final teacherRequest=await teacherRemoteDataSource.acceptOrRejectRequestTeacher(statusId: statusId, teacherId: teacherId);
       return Right(teacherRequest);
     }on ServerException{
       return Left(ServerFailure());
     }
   }else{
     return Left(OffLineFailure());
   }
  }

  @override
  Future<Either<Failure, TeachersEntity>> getTeachers({required List<String> languages, required int numberPage})async {
    if(await networkInfo.isConnected){
      try{
        final TeachersEntity teachers=await teacherRemoteDataSource.getTeachers(languages: languages,page: numberPage);
        return Right(teachers);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, TeacherEntity>> getTeacher({required int teacherId}) async{
   if(await networkInfo.isConnected)
     {
       try{
         final TeacherEntity teacher=await teacherRemoteDataSource.getTeacher(teacherId:teacherId);
         return Right(teacher);
       }on ServerException{
        return Left(ServerFailure());
       }
     }else{
     return Left(OffLineFailure());
   }
  }

}
