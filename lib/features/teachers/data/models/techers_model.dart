import '../../../auth/data/models/user_model.dart';
import '../../domain/entities/teachers_entity.dart';

class TeachersModel extends TeachersEntity {
  TeachersModel({
    required super.data,
    required super.links,
    required super.meta,
  });

  factory TeachersModel.fromJson(Map<String, dynamic> json) => TeachersModel(
        data: List<ItemTeacherModel>.from(
            json["data"].map((x) => ItemTeacherModel.fromJson(x))),
        links: LinksModel.fromJson(json["links"]),
        meta: MetaModel.fromJson(json["meta"]),
      );
}

class ItemTeacherModel extends ItemTeacherEntity {
  ItemTeacherModel({
    required super.teacherId,
    required super.rating,
    required super.userInfo,
    required super.createdAt,
    required super.workingDays,
    required super.languages,
    required super.status,
  });

  factory ItemTeacherModel.fromJson(Map<String, dynamic> json) =>
      ItemTeacherModel(
        teacherId: json["teacher_id"],
        status: json["status"],
        rating: json["rating"],
        userInfo: UserModel.fromJson(json["user_info"]),
        languages: List<LanguagesModel>.from(json["languages"]
            .map((language) => LanguagesModel.fromJson(language))),
        createdAt: json["created_at"],
        workingDays: List<WorkingDayModel>.from(
            json["working_days"].map((workingDay) => WorkingDayModel.fromJson(workingDay))),
      );
}

class LanguagesModel extends LanguagesEntity {
  LanguagesModel(
      {required super.language,
      required super.level,
      required super.yearsOfExperience});

  factory LanguagesModel.fromJson(Map<String, dynamic> json) => LanguagesModel(
      language: json["language"],
      level: json["level"],
      yearsOfExperience: json["years_of_experience"]);
}

class WorkingDayModel extends WorkingDayEntity {
  WorkingDayModel({
    required super.id,
    required super.dayName,
    required super.workingTimes,
  });

  factory WorkingDayModel.fromJson(Map<String, dynamic> json) =>
      WorkingDayModel(
        id: json["id"],
        dayName: json["day_name"],
        workingTimes: List<WorkingTimeModel>.from(
            json["working_times"].map((x) => WorkingTimeModel.fromJson(x))),
      );
}

class WorkingTimeModel extends WorkingTimeEntity {
  WorkingTimeModel({
    required super.id,
    required super.first,
    required super.end,
    required super.workingDayId,
  });

  factory WorkingTimeModel.fromJson(Map<String, dynamic> json) =>
      WorkingTimeModel(
        id: json["id"],
        first: json["first"],
        end: json["end"],
        workingDayId: json["working_day_id"],
      );
}

class LinksModel extends LinksEntity {
  LinksModel({
    required super.first,
    required super.last,
    super.prev,
    super.next,
  });

  factory LinksModel.fromJson(Map<String, dynamic> json) => LinksModel(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );
}

class MetaModel extends MetaEntity {
  MetaModel({
    required super.currentPage,
    required super.from,
    required super.lastPage,
    required super.links,
    required super.path,
    required super.perPage,
    required super.to,
    required super.total,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) => MetaModel(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: List<LinkModel>.from(
            json["links"].map((x) => LinkModel.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );
}

class LinkModel extends LinkEntity {
  LinkModel({
    super.url,
    required super.label,
    required super.active,
  });

  factory LinkModel.fromJson(Map<String, dynamic> json) => LinkModel(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );
}
