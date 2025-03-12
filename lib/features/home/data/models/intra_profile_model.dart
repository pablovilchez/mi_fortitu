import 'package:mi_fortitu/features/home/domain/entities/intra_profile.dart';

class IntraProfileModel extends IntraProfile {
  IntraProfileModel({
    required super.id,
    required super.email,
    required super.login,
    required super.firstName,
    required super.lastName,
    required super.usualFullName,
    required super.usualFirstName,
    required super.profileUrl,
    required super.displayName,
    required super.kind,
    required super.image,
    required super.staff,
    required super.correctionPoint,
    required super.poolMonth,
    required super.poolYear,
    required super.wallet,
    required super.createdAt,
    required super.updatedAt,
    required super.alumnizedAt,
    required super.alumni,
    required super.active,
    required super.groups,
    required super.cursusUsers,
    required super.projectsUsers,
    required super.languagesUsers,
    required super.achievements,
    required super.titles,
    required super.titlesUsers,
    required super.expertisesUsers,
    required super.campus,
    required super.campusUsers,
  });

  factory IntraProfileModel.fromJson(Map<String, dynamic> json) {
    return IntraProfileModel(
      id: json["id"],
      email: json["email"],
      login: json["login"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      usualFullName: json["usual_full_name"],
      usualFirstName: json["usual_first_name"] ?? "",
      profileUrl: json["url"],
      displayName: json["displayname"],
      kind: json["kind"],
      image: ProfileImagesModel.fromJson(json["image"]),
      staff: json["staff?"],
      correctionPoint: json["correction_point"] ?? 0,
      poolMonth: json["pool_month"] ?? "None",
      poolYear: json["pool_year"] ?? "None",
      wallet: json["wallet"] ?? 0,
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
      alumnizedAt: json["alumnized_at"] ?? "",
      alumni: json["alumni?"],
      active: json["active?"],
      groups: List<dynamic>.from(json["groups"].map((x) => x)),
      cursusUsers:
          json["cursus_users"]
              .map<CursusUser>((x) => CursusUserModel.fromJson(x).toEntity())
              .toList(),
      projectsUsers:
          json["projects_users"]
              .map<ProjectsUser>(
                (x) => ProjectsUserModel.fromJson(x).toEntity(),
              )
              .toList(),
      languagesUsers:
          json["languages_users"]
              .map<LanguagesUser>(
                (x) => LanguagesUserModel.fromJson(x).toEntity(),
              )
              .toList(),
      achievements:
          json["achievements"]
              .map<Achievement>((x) => AchievementModel.fromJson(x).toEntity())
              .toList(),
      titles:
          json["titles"]
              .map<Title>((x) => TitleModel.fromJson(x).toEntity())
              .toList(),
      titlesUsers:
          json["titles_users"]
              .map<TitlesUser>((x) => TitlesUserModel.fromJson(x).toEntity())
              .toList(),
      expertisesUsers:
          json["expertises_users"]
              .map<ExpertisesUser>(
                (x) => ExpertisesUserModel.fromJson(x).toEntity(),
              )
              .toList(),
      campus:
          json["campus"]
              .map<Campus>((x) => CampusModel.fromJson(x).toEntity())
              .toList(),
      campusUsers:
          json["campus_users"]
              .map<CampusUser>((x) => CampusUserModel.fromJson(x).toEntity())
              .toList(),
    );
  }
}

class ProfileImagesModel extends ProfileImages {
  ProfileImagesModel({required super.link, required super.versions});

  factory ProfileImagesModel.fromJson(Map<String, dynamic> json) {
    return ProfileImagesModel(
      link: json["link"],
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
      large: json["large"],
      medium: json["medium"],
      small: json["small"],
      micro: json["micro"],
    );
  }

  Versions toEntity() {
    return Versions(large: large, medium: medium, small: small, micro: micro);
  }
}

class CursusUserModel extends CursusUser {
  CursusUserModel({
    required super.id,
    required super.beginAt,
    required super.endAt,
    required super.grade,
    required super.level,
    required super.skills,
    required super.cursusId,
    required super.hasCoalition,
    required super.blackholedAt,
    required super.createdAt,
    required super.updatedAt,
    required super.cursus,
  });

  factory CursusUserModel.fromJson(Map<String, dynamic> json) {
    return CursusUserModel(
      id: json["id"],
      beginAt: json["begin_at"] ?? "",
      endAt: json["end_at"] ?? "",
      grade: json["grade"] ?? "",
      level: json["level"]?.toDouble(),
      skills: List<SkillModel>.from(
        json["skills"].map((x) => SkillModel.fromJson(x)),
      ),
      cursusId: json["cursus_id"],
      hasCoalition: json["has_coalition"],
      blackholedAt: json["blackholed_at"] ?? "",
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
      cursus: CursusModel.fromJson(json["cursus"]),
    );
  }

  CursusUser toEntity() {
    return CursusUser(
      id: id,
      beginAt: beginAt,
      endAt: endAt,
      grade: grade,
      level: level,
      skills: skills,
      cursusId: cursusId,
      hasCoalition: hasCoalition,
      blackholedAt: blackholedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      cursus: cursus,
    );
  }
}

class SkillModel extends Skill {
  SkillModel({required super.id, required super.name, required super.level});

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      id: json["id"],
      name: json["name"],
      level: json["level"]?.toDouble(),
    );
  }

  Skill toEntity() {
    return Skill(id: id, name: name, level: level);
  }
}

class CursusModel extends Cursus {
  CursusModel({
    required super.id,
    required super.createdAt,
    required super.name,
    required super.slug,
    required super.kind,
  });

  factory CursusModel.fromJson(Map<String, dynamic> json) {
    return CursusModel(
      id: json["id"],
      createdAt: json["created_at"],
      name: json["name"],
      slug: json["slug"],
      kind: json["kind"],
    );
  }

  Cursus toEntity() {
    return Cursus(
      id: id,
      createdAt: createdAt,
      name: name,
      slug: slug,
      kind: kind,
    );
  }
}

class ProjectsUserModel extends ProjectsUser {
  ProjectsUserModel({
    required super.id,
    required super.occurrence,
    required super.finalMark,
    required super.status,
    required super.validated,
    required super.currentTeamId,
    required super.project,
    required super.cursusIds,
    required super.markedAt,
    required super.marked,
    required super.retriableAt,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProjectsUserModel.fromJson(Map<String, dynamic> json) {
    return ProjectsUserModel(
      id: json["id"],
      occurrence: json["occurrence"],
      finalMark: json["final_mark"] ?? 0,
      status: json["status"] ?? 'undefined',
      validated: json["validated?"] ?? false,
      currentTeamId: json["current_team_id"],
      project: ProjectModel.fromJson(json["project"]),
      cursusIds: List<int>.from(json["cursus_ids"].map((x) => x)),
      markedAt: json["marked_at"] ?? "",
      marked: json["marked"],
      retriableAt: json["retriable_at"] ?? "",
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
    );
  }

  ProjectsUser toEntity() {
    return ProjectsUser(
      id: id,
      occurrence: occurrence,
      finalMark: finalMark,
      status: status,
      validated: validated,
      currentTeamId: currentTeamId,
      project: project,
      cursusIds: cursusIds,
      markedAt: markedAt,
      marked: marked,
      retriableAt: retriableAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class ProjectModel extends Project {
  ProjectModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.parentId,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      parentId: json["parent_id"] ?? 0,
    );
  }

  Project toEntity() {
    return Project(id: id, name: name, slug: slug, parentId: parentId);
  }
}

class LanguagesUserModel extends LanguagesUser {
  LanguagesUserModel({
    required super.id,
    required super.languageId,
    required super.userId,
    required super.position,
    required super.createdAt,
  });

  factory LanguagesUserModel.fromJson(Map<String, dynamic> json) {
    return LanguagesUserModel(
      id: json["id"],
      languageId: json["language_id"],
      userId: json["user_id"],
      position: json["position"],
      createdAt: json["created_at"] ?? "",
    );
  }

  LanguagesUser toEntity() {
    return LanguagesUser(
      id: id,
      languageId: languageId,
      userId: userId,
      position: position,
      createdAt: createdAt,
    );
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
      name: json["name"],
      description: json["description"],
      tier: json["tier"] ?? 'none',
      kind: json["kind"] ?? 'none',
      visible: json["visible"],
      image: json["image"],
      nbrOfSuccess: json["nbr_of_success"] ?? 0,
      usersUrl: json["users_url"],
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
      userId: json["user_id"],
      titleId: json["title_id"],
      selected: json["selected"],
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

class ExpertisesUserModel extends ExpertisesUser {
  ExpertisesUserModel({
    required super.id,
    required super.expertiseId,
    required super.interested,
    required super.value,
    required super.contactMe,
    required super.createdAt,
    required super.userId,
  });

  factory ExpertisesUserModel.fromJson(Map<String, dynamic> json) {
    return ExpertisesUserModel(
      id: json["id"],
      expertiseId: json["expertise_id"],
      interested: json["interested"],
      value: json["value"],
      contactMe: json["contact_me"],
      createdAt: json["created_at"] ?? "",
      userId: json["user_id"],
    );
  }

  ExpertisesUser toEntity() {
    return ExpertisesUser(
      id: id,
      expertiseId: expertiseId,
      interested: interested,
      value: value,
      contactMe: contactMe,
      createdAt: createdAt,
      userId: userId,
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
      name: json["name"],
      timeZone: json["time_zone"],
      language: LanguageModel.fromJson(json["language"]),
      usersCount: json["users_count"],
      vogsphereId: json["vogsphere_id"],
      country: json["country"],
      address: json["address"],
      zip: json["zip"],
      city: json["city"],
      website: json["website"],
      facebook: json["facebook"],
      twitter: json["twitter"],
      active: json["active"],
      public: json["public"],
      emailExtension: json["email_extension"],
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
      name: json["name"],
      identifier: json["identifier"],
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
      campusId: json["campus_id"],
      isPrimary: json["is_primary"],
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
