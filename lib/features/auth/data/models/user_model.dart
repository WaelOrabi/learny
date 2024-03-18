
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity{

  UserModel(
      {super.userId,
       required super.firstName,
        super.fatherName,
       required super.lastName,
       required super.email,
       required super.gender,
       required super.phoneNumber,
       required super.birthDate,
        super.verified,
        super.hours,
        super.points,
        super.personalImage,
        super.nationality,
        super.roles,
        super.accessToken,
        super.nationalityId,
      super.confirmPassword,
        super.password
      });

 factory UserModel.fromJson(Map<String, dynamic> json) {
   List<RolesModel>roles = <RolesModel>[];
   if(json['roles']!=null) {
     json['roles'].forEach((v) {
     roles.add(RolesModel.fromJson(v));
   });
   }
   return UserModel(userId: json['user_id'],
       firstName: json['first_name'],
       fatherName: json['father_name'],
       lastName: json['last_name'],
       email: json['email'],
       gender: json['gender'],
       phoneNumber: json['phone_number'],
       birthDate: json['birth_date'],
       verified: json['verified'],
       hours: json['hours'],
       points: json['points'],
       personalImage: json['personal_image'],
       nationality: NationalityModel.fromJson(json['nationality']),
       roles: roles,
       accessToken: json['access_token']);
 }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    userId!=null?data['user_id'] = userId:"";
    data['first_name'] = firstName;
   fatherName!=null? data['father_name'] = fatherName:"";
    data['last_name'] = lastName;
    data['email'] = email;
    data['gender'] = gender;
    data['phone_number'] = phoneNumber;
    data['birth_date'] = birthDate;
    confirmPassword!=null?data['password_confirmation']=confirmPassword:"";
    password!=null?data['password']=password:"";
    verified!=null?data['verified'] = verified:"";
   hours!=null? data['hours'] = hours:"";
   points!=null? data['points'] = points:"";
    personalImage!=null? data['personal_image'] = personalImage:"";
   nationality!=null?   data['nationality'] = NationalityModel(name: nationality!.name,nationalityId: nationality!.nationalityId).toJson():"";
   nationalityId!=null?data['nationality_id'] = nationalityId:"";

     roles!=null? data['roles'] = roles!.map((v) => RolesModel(roleId: v.roleId,name: v.name).toJson()).toList():"";

   accessToken!=null? data['access_token'] = accessToken:"";
    return data;
  }
}

class NationalityModel extends NationalityEntity{


  NationalityModel({super.nationalityId, super.name});

  factory NationalityModel.fromJson(Map<String, dynamic> json) {
    return NationalityModel(nationalityId:json['nationality_id'],name: json['name'] );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nationality_id'] = nationalityId;
    data['name'] = name;
    return data;
  }
}

class RolesModel extends RolesEntity{


  RolesModel({super.roleId, super.name});

 factory RolesModel.fromJson(Map<String, dynamic> json) {
   return RolesModel(roleId: json['role_id'],name:json['name'] );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role_id'] = roleId;
    data['name'] = name;
    return data;
  }
}
