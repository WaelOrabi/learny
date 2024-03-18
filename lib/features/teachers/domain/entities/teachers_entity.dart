
import 'package:learny_project/features/auth/data/models/user_model.dart';

class TeachersEntity {
  TeachersEntity({
    required this.data,
    required this.links,
    required this.meta,
  });

  List<ItemTeacherEntity> data;
  LinksEntity links;
  MetaEntity meta;
}

class ItemTeacherEntity {
  ItemTeacherEntity({
    required this.teacherId,
    required this.rating,
    required this.userInfo,
    required this.createdAt,
    required this.workingDays,
    required this.languages,
    required this.status,
  });

  int teacherId;
  double rating;
  UserModel userInfo;
  String createdAt;
  String status;
  List<LanguagesEntity> languages;
  List<WorkingDayEntity> workingDays;
}
class LanguagesEntity {

  String language;
  String level;
  int yearsOfExperience;

  LanguagesEntity({required this.language,required this.level,required this.yearsOfExperience});
}

class WorkingDayEntity {
  WorkingDayEntity({
    required this.id,
    required this.dayName,
    required this.workingTimes,
  });

  int id;
  String dayName;
  List<WorkingTimeEntity> workingTimes;
}

class WorkingTimeEntity {
  WorkingTimeEntity({
    required this.id,
    required this.first,
    required this.end,
    required this.workingDayId,
  });

  int id;
  String first;
  String end;
  int workingDayId;
}

class LinksEntity {
  LinksEntity({
    required this.first,
    required this.last,
    this.prev,
    this.next,
  });

  String ?first;
  String? last;
  String? prev;
  String? next;
}

class MetaEntity {
  MetaEntity({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  int ?currentPage;
  int ?from;
  int ?lastPage;
  List<LinkEntity>? links;
  String ?path;
  int ?perPage;
  int ?to;
  int ?total;
}

class LinkEntity {
  LinkEntity({
    this.url,
    required this.label,
    required this.active,
  });

  String? url;
  String? label;
  bool? active;
}
