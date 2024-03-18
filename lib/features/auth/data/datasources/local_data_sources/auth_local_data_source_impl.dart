
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/strings/cached.dart';
import '../../../domain/entities/user_entity.dart';
import '../../models/user_model.dart';
import 'auth_local_data_sources.dart';

class AuthLocalDataSourcesImpl implements AuthLocalDataSources{
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourcesImpl({required this.sharedPreferences});


  @override
  Future<Unit> cachedUser({required UserModel userModel})async {
    final userModelToJson=userModel.toJson();
    sharedPreferences.setString(CACHED_USER, json.encode(userModelToJson));

    return Future.value(unit);

  }

  @override
  Future<UserModel> getCachedUser() {
    final jsonString = sharedPreferences.getString(CACHED_USER);

    if (jsonString != null) {
      final decodeJsonData = json.decode(jsonString);
      UserModel jsonToUserModel = UserModel.fromJson(decodeJsonData);
      return Future.value(jsonToUserModel);
    }else{
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> deleteCachedUser() async{

    await sharedPreferences.remove(CACHED_USER);
    return Future.value(unit);
  }
}

