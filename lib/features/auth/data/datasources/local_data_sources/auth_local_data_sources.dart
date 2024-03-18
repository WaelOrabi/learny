import 'package:dartz/dartz.dart';
import '../../../domain/entities/user_entity.dart';
import '../../models/user_model.dart';


abstract class AuthLocalDataSources{
  Future<Unit> cachedUser({required UserModel userModel});
Future <UserModel> getCachedUser();
Future<Unit> deleteCachedUser();
}
