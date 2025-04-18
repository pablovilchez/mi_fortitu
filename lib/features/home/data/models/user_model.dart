import 'package:mi_fortitu/features/home/data/models/project_user_model.dart';
import 'package:mi_fortitu/features/home/domain/entities/user_entity.dart';

import '../../domain/entities/cursus_user_entity.dart';
import '../../domain/entities/project_user_entity.dart';
import 'cursus_user_model.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.login,
    required super.firstName,
    required super.lastName,
    required super.profileUrl,
    required super.kind,
    required super.image,
    required super.staff,
    required super.correctionPoint,
    required super.poolMonth,
    required super.poolYear,
    required super.wallet,
    required super.alumni,
    required super.active,
    required super.cursusUsers,
    required super.projectsUsers,
    required super.achievements,
    required super.titles,
    required super.titlesUsers,
    required super.campus,
    required super.campusUsers,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      email: json["email"] ?? "",
      login: json["login"] ?? "",
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      profileUrl: json["url"] ?? "",
      kind: json["kind"] ?? "",
      image: ProfileImagesModel.fromJson(json["image"]),
      staff: json["staff?"] ?? false,
      correctionPoint: json["correction_point"] ?? 0,
      poolMonth: json["pool_month"] ?? "None",
      poolYear: json["pool_year"] ?? "None",
      wallet: json["wallet"] ?? 0,
      alumni: json["alumni?"] ?? false,
      active: json["active?"] ?? false,
      cursusUsers:
          json["cursus_users"]
              .map<CursusUserEntity>((x) => CursusUserModel.fromJson(x).toEntity())
              .toList(),
      projectsUsers:
          json["projects_users"]
              .map<ProjectUserEntity>((x) => ProjectUserModel.fromJson(x).toEntity())
              .toList(),
      achievements:
          json["achievements"]
              .map<Achievement>((x) => AchievementModel.fromJson(x).toEntity())
              .toList(),
      titles: json["titles"].map<Title>((x) => TitleModel.fromJson(x).toEntity()).toList(),
      titlesUsers:
          json["titles_users"]
              .map<TitlesUser>((x) => TitlesUserModel.fromJson(x).toEntity())
              .toList(),
      campus: json["campus"].map<Campus>((x) => CampusModel.fromJson(x).toEntity()).toList(),
      campusUsers:
          json["campus_users"]
              .map<CampusUser>((x) => CampusUserModel.fromJson(x).toEntity())
              .toList(),
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      login: login,
      firstName: firstName,
      lastName: lastName,
      profileUrl: profileUrl,
      kind: kind,
      image: image,
      staff: staff,
      correctionPoint: correctionPoint,
      poolMonth: poolMonth,
      poolYear: poolYear,
      wallet: wallet,
      alumni: alumni,
      active: active,
      cursusUsers: cursusUsers,
      projectsUsers: projectsUsers,
      achievements: achievements,
      titles: titles,
      titlesUsers: titlesUsers,
      campus: campus,
      campusUsers: campusUsers,
    );
  }
}

class ProfileImagesModel extends ProfileImages {
  ProfileImagesModel({required super.link, required super.versions});

  factory ProfileImagesModel.fromJson(Map<String, dynamic> json) {
    return ProfileImagesModel(
      link: json["link"] ?? "",
      versions: VersionsModel.fromJson(json["versions"]),
    );
  }

  ProfileImages toEntity() {
    return ProfileImages(link: link, versions: versions);
  }
}

class VersionsModel extends Versions {
  VersionsModel({
    required super.large,
    required super.medium,
    required super.small,
    required super.micro,
  });

  factory VersionsModel.fromJson(Map<String, dynamic> json) {
    return VersionsModel(
      large: json["large"] ?? "",
      medium: json["medium"] ?? "",
      small: json["small"] ?? "",
      micro: json["micro"] ?? "",
    );
  }

  Versions toEntity() {
    return Versions(large: large, medium: medium, small: small, micro: micro);
  }
}

class AchievementModel extends Achievement {
  AchievementModel({
    required super.id,
    required super.name,
    required super.description,
    required super.tier,
    required super.kind,
    required super.visible,
    required super.image,
    required super.nbrOfSuccess,
    required super.usersUrl,
  });

  factory AchievementModel.fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      id: json["id"],
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      tier: json["tier"] ?? 'none',
      kind: json["kind"] ?? 'none',
      visible: json["visible"] ?? false,
      image: json["image"] ?? "",
      nbrOfSuccess: json["nbr_of_success"] ?? 0,
      usersUrl: json["users_url"] ?? "",
    );
  }

  Achievement toEntity() {
    return Achievement(
      id: id,
      name: name,
      description: description,
      tier: tier,
      kind: kind,
      visible: visible,
      image: image,
      nbrOfSuccess: nbrOfSuccess,
      usersUrl: usersUrl,
    );
  }
}

class TitleModel extends Title {
  TitleModel({required super.id, required super.name});

  factory TitleModel.fromJson(Map<String, dynamic> json) {
    return TitleModel(id: json["id"], name: json["name"]);
  }

  Title toEntity() {
    return Title(id: id, name: name);
  }
}

class TitlesUserModel extends TitlesUser {
  TitlesUserModel({
    required super.id,
    required super.userId,
    required super.titleId,
    required super.selected,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TitlesUserModel.fromJson(Map<String, dynamic> json) {
    return TitlesUserModel(
      id: json["id"],
      userId: json["user_id"] ?? -1,
      titleId: json["title_id"] ?? -1,
      selected: json["selected"] ?? false,
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
    );
  }

  TitlesUser toEntity() {
    return TitlesUser(
      id: id,
      userId: userId,
      titleId: titleId,
      selected: selected,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class CampusModel extends Campus {
  CampusModel({
    required super.id,
    required super.name,
    required super.timeZone,
    required super.language,
    required super.usersCount,
    required super.vogsphereId,
    required super.country,
    required super.address,
    required super.zip,
    required super.city,
    required super.website,
    required super.facebook,
    required super.twitter,
    required super.active,
    required super.public,
    required super.emailExtension,
  });

  factory CampusModel.fromJson(Map<String, dynamic> json) {
    return CampusModel(
      id: json["id"],
      name: json["name"] ?? "",
      timeZone: json["time_zone"] ?? "",
      language: LanguageModel.fromJson(json["language"]),
      usersCount: json["users_count"] ?? 0,
      vogsphereId: json["vogsphere_id"] ?? 0,
      country: json["country"] ?? "",
      address: json["address"] ?? "",
      zip: json["zip"] ?? "",
      city: json["city"] ?? "",
      website: json["website"] ?? "",
      facebook: json["facebook"] ?? "",
      twitter: json["twitter"] ?? "",
      active: json["active"] ?? false,
      public: json["public"] ?? false,
      emailExtension: json["email_extension"] ?? "",
    );
  }

  Campus toEntity() {
    return Campus(
      id: id,
      name: name,
      timeZone: timeZone,
      language: language,
      usersCount: usersCount,
      vogsphereId: vogsphereId,
      country: country,
      address: address,
      zip: zip,
      city: city,
      website: website,
      facebook: facebook,
      twitter: twitter,
      active: active,
      public: public,
      emailExtension: emailExtension,
    );
  }
}

class LanguageModel extends Language {
  LanguageModel({
    required super.id,
    required super.name,
    required super.identifier,
    required super.createdAt,
    required super.updatedAt,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      id: json["id"],
      name: json["name"] ?? "",
      identifier: json["identifier"] ?? "",
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
    );
  }

  Language toEntity() {
    return Language(
      id: id,
      name: name,
      identifier: identifier,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class CampusUserModel extends CampusUser {
  CampusUserModel({
    required super.id,
    required super.userId,
    required super.campusId,
    required super.isPrimary,
    required super.createdAt,
    required super.updatedAt,
  });

  factory CampusUserModel.fromJson(Map<String, dynamic> json) {
    return CampusUserModel(
      id: json["id"],
      userId: json["user_id"],
      campusId: json["campus_id"] ?? -1,
      isPrimary: json["is_primary"] ?? false,
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
    );
  }

  CampusUser toEntity() {
    return CampusUser(
      id: id,
      userId: userId,
      campusId: campusId,
      isPrimary: isPrimary,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
