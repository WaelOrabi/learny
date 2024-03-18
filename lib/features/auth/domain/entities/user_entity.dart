
class UserEntity {
  int? userId;
  String firstName;
  String ?fatherName;
  String lastName;
  String email;
  String gender;
  String phoneNumber;
  String birthDate;
  bool? verified;
  int? hours;
  int? points;
  String? personalImage;
  String? confirmPassword;
  String?password;
  NationalityEntity? nationality;
  List<RolesEntity>? roles;
  String? accessToken;
//////
  String? nationalityId;
  UserEntity(
      {this.userId,
        required this.firstName,
        this.fatherName,
        required this.lastName,
        required this.email,
        required this.gender,
        required this.phoneNumber,
        required this.birthDate,
        this.verified,
        this.hours,
        this.points,
        this.personalImage,
        this.nationality,
        this.roles,
        this.accessToken,
        this.nationalityId,
        this.confirmPassword,
        this.password
      });

}

class NationalityEntity{
  int? nationalityId;
  String? name;

  NationalityEntity({this.nationalityId, this.name});

}

class RolesEntity {
  int? roleId;
  String? name;

  RolesEntity({this.roleId, this.name});

}
