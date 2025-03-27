import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));


class Profile {
  int id;
  String email;
  String login;
  String firstName;
  String lastName;
  String usualFullName;
  String usualFirstName;
  String profileUrl;
  String displayName;
  UserKind kind;
  ProfileImages image;
  bool staff;
  int correctionPoint;
  String poolMonth;
  String poolYear;
  int wallet;
  String createdAt;
  String updatedAt;
  String alumnizedAt;
  bool alumni;
  bool active;
  List<dynamic> groups;
  List<CursusUser> cursusUsers;
  List<ProjectsUser> projectsUsers;
  List<LanguagesUser> languagesUsers;
  List<Achievement> achievements;
  List<Title> titles;
  List<TitlesUser> titlesUsers;
  List<ExpertisesUser> expertisesUsers;
  List<Campus> campus;
  List<CampusUser> campusUsers;

  Profile({
    required this.id,
    required this.email,
    required this.login,
    required this.firstName,
    required this.lastName,
    required this.usualFullName,
    required this.usualFirstName,
    required this.profileUrl,
    required this.displayName,
    required this.kind,
    required this.image,
    required this.staff,
    required this.correctionPoint,
    required this.poolMonth,
    required this.poolYear,
    required this.wallet,
    required this.createdAt,
    required this.updatedAt,
    required this.alumnizedAt,
    required this.alumni,
    required this.active,
    required this.groups,
    required this.cursusUsers,
    required this.projectsUsers,
    required this.languagesUsers,
    required this.achievements,
    required this.titles,
    required this.titlesUsers,
    required this.expertisesUsers,
    required this.campus,
    required this.campusUsers,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    email: json["email"],
    login: json["auth"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    usualFullName: json["usual_full_name"],
    usualFirstName: json["usual_first_name"] ?? "",
    profileUrl: json["url"],
    displayName: json["displayname"],
    kind: json["kind"],
    image: ProfileImages.fromJson(json["image"]),
    staff: json["staff?"],
    correctionPoint: json["correction_point"],
    poolMonth: json["pool_month"],
    poolYear: json["pool_year"],
    wallet: json["wallet"],
    createdAt: json["created_at"] ?? "",
    updatedAt: json["updated_at"] ?? "",
    alumnizedAt: json["alumnized_at"] ?? "",
    alumni: json["alumni?"],
    active: json["active?"],
    groups: List<dynamic>.from(json["groups"].map((x) => x)),
    cursusUsers: List<CursusUser>.from(json["cursus_users"].map((x) => CursusUser.fromJson(x))),
    projectsUsers: List<ProjectsUser>.from(json["projects_users"].map((x) => ProjectsUser.fromJson(x))),
    languagesUsers: List<LanguagesUser>.from(json["languages_users"].map((x) => LanguagesUser.fromJson(x))),
    achievements: List<Achievement>.from(json["achievements"].map((x) => Achievement.fromJson(x))),
    titles: List<Title>.from(json["titles"].map((x) => Title.fromJson(x))),
    titlesUsers: List<TitlesUser>.from(json["titles_users"].map((x) => TitlesUser.fromJson(x))),
    expertisesUsers: List<ExpertisesUser>.from(json["expertises_users"].map((x) => ExpertisesUser.fromJson(x))),
    campus: List<Campus>.from(json["campus"].map((x) => Campus.fromJson(x))),
    campusUsers: List<CampusUser>.from(json["campus_users"].map((x) => CampusUser.fromJson(x))),
  );
}

class Achievement {
  int id;
  String name;
  String description;
  Tier tier;
  AchievementKind kind;
  bool visible;
  String image;
  int nbrOfSuccess;
  String usersUrl;

  Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.tier,
    required this.kind,
    required this.visible,
    required this.image,
    required this.nbrOfSuccess,
    required this.usersUrl,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) => Achievement(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    tier: tierValues.map[json["tier"]]!,
    kind: kindValues.map[json["kind"]]!,
    visible: json["visible"],
    image: json["image"],
    nbrOfSuccess: json["nbr_of_success"] ?? 0,
    usersUrl: json["users_url"],
  );
}

enum AchievementKind {
  PEDAGOGY,
  PROJECT,
  SCOLARITY,
  SOCIAL
}

final kindValues = EnumValues({
  "pedagogy": AchievementKind.PEDAGOGY,
  "project": AchievementKind.PROJECT,
  "scolarity": AchievementKind.SCOLARITY,
  "social": AchievementKind.SOCIAL
});

enum Tier {
  CHALLENGE,
  EASY,
  HARD,
  MEDIUM,
  NONE
}

final tierValues = EnumValues({
  "challenge": Tier.CHALLENGE,
  "easy": Tier.EASY,
  "hard": Tier.HARD,
  "medium": Tier.MEDIUM,
  "none": Tier.NONE
});

class Campus {
  int id;
  String name;
  String timeZone;
  Language language;
  int usersCount;
  int vogsphereId;
  String country;
  String address;
  String zip;
  String city;
  String website;
  String facebook;
  String twitter;
  bool active;
  bool public;
  String emailExtension;

  Campus({
    required this.id,
    required this.name,
    required this.timeZone,
    required this.language,
    required this.usersCount,
    required this.vogsphereId,
    required this.country,
    required this.address,
    required this.zip,
    required this.city,
    required this.website,
    required this.facebook,
    required this.twitter,
    required this.active,
    required this.public,
    required this.emailExtension,
  });

  factory Campus.fromJson(Map<String, dynamic> json) => Campus(
    id: json["id"],
    name: json["name"],
    timeZone: json["time_zone"],
    language: Language.fromJson(json["language"]),
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

class Language {
  int id;
  String name;
  String identifier;
  String createdAt;
  String updatedAt;

  Language({
    required this.id,
    required this.name,
    required this.identifier,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    id: json["id"],
    name: json["name"],
    identifier: json["identifier"],
    createdAt: json["created_at"] ?? "",
    updatedAt: json["updated_at"] ?? "",
  );
}

class CampusUser {
  int id;
  int userId;
  int campusId;
  bool isPrimary;
  String createdAt;
  String updatedAt;

  CampusUser({
    required this.id,
    required this.userId,
    required this.campusId,
    required this.isPrimary,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CampusUser.fromJson(Map<String, dynamic> json) => CampusUser(
    id: json["id"],
    userId: json["user_id"],
    campusId: json["campus_id"],
    isPrimary: json["is_primary"],
    createdAt: json["created_at"] ?? "",
    updatedAt: json["updated_at"] ?? "",
  );
}

class CursusUser {
  int id;
  String beginAt;
  String endAt;
  String grade;
  double level;
  List<Skill> skills;
  int cursusId;
  bool hasCoalition;
  String blackholedAt;
  String createdAt;
  String updatedAt;
  Cursus cursus;

  CursusUser({
    required this.id,
    required this.beginAt,
    required this.endAt,
    required this.grade,
    required this.level,
    required this.skills,
    required this.cursusId,
    required this.hasCoalition,
    required this.blackholedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.cursus,
  });

  factory CursusUser.fromJson(Map<String, dynamic> json) => CursusUser(
    id: json["id"],
    beginAt: json["begin_at"] ?? "",
    endAt: json["end_at"] ?? "",
    grade: json["grade"],
    level: json["level"]?.toDouble(),
    skills: List<Skill>.from(json["skills"].map((x) => Skill.fromJson(x))),
    cursusId: json["cursus_id"],
    hasCoalition: json["has_coalition"],
    blackholedAt: json["blackholed_at"],
    createdAt: json["created_at"] ?? "",
    updatedAt: json["updated_at"] ?? "",
    cursus: Cursus.fromJson(json["cursus"]),
  );
}

class Cursus {
  int id;
  String createdAt;
  String name;
  String slug;
  String kind;

  Cursus({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.slug,
    required this.kind,
  });

  factory Cursus.fromJson(Map<String, dynamic> json) => Cursus(
    id: json["id"],
    createdAt: json["created_at"] ?? "",
    name: json["name"],
    slug: json["slug"],
    kind: json["kind"],
  );
}

class Skill {
  int id;
  String name;
  double level;

  Skill({
    required this.id,
    required this.name,
    required this.level,
  });

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
    id: json["id"],
    name: json["name"],
    level: json["level"]?.toDouble(),
  );
}

class ProfileImages {
  String link;
  Versions versions;

  ProfileImages({
    required this.link,
    required this.versions,
  });

  factory ProfileImages.fromJson(Map<String, dynamic> json) => ProfileImages(
    link: json["link"],
    versions: Versions.fromJson(json["versions"]),
  );
}

class Versions {
  String large;
  String medium;
  String small;
  String micro;

  Versions({
    required this.large,
    required this.medium,
    required this.small,
    required this.micro,
  });

  factory Versions.fromJson(Map<String, dynamic> json) => Versions(
    large: json["large"],
    medium: json["medium"],
    small: json["small"],
    micro: json["micro"],
  );
}

enum UserKind {
  USER,
  ADMIN,
  GUEST
}

final userKindValues = EnumValues({
  "admin": UserKind.ADMIN,
  "guest": UserKind.GUEST,
  "user": UserKind.USER
});

class ExpertisesUser {
  int id;
  int expertiseId;
  bool interested;
  int value;
  bool contactMe;
  String createdAt;
  int userId;

  ExpertisesUser({
    required this.id,
    required this.expertiseId,
    required this.interested,
    required this.value,
    required this.contactMe,
    required this.createdAt,
    required this.userId,
  });

  factory ExpertisesUser.fromJson(Map<String, dynamic> json) => ExpertisesUser(
    id: json["id"],
    expertiseId: json["expertise_id"],
    interested: json["interested"],
    value: json["value"],
    contactMe: json["contact_me"],
    createdAt: json["created_at"] ?? "",
    userId: json["user_id"],
  );
}

class LanguagesUser {
  int id;
  int languageId;
  int userId;
  int position;
  String createdAt;

  LanguagesUser({
    required this.id,
    required this.languageId,
    required this.userId,
    required this.position,
    required this.createdAt,
  });

  factory LanguagesUser.fromJson(Map<String, dynamic> json) => LanguagesUser(
    id: json["id"],
    languageId: json["language_id"],
    userId: json["user_id"],
    position: json["position"],
    createdAt: json["created_at"] ?? "",
  );
}

class ProjectsUser {
  int id;
  int occurrence;
  int finalMark;
  Status status;
  bool validated;
  int currentTeamId;
  Project project;
  List<int> cursusIds;
  String markedAt;
  bool marked;
  String retriableAt;
  String createdAt;
  String updatedAt;

  ProjectsUser({
    required this.id,
    required this.occurrence,
    required this.finalMark,
    required this.status,
    required this.validated,
    required this.currentTeamId,
    required this.project,
    required this.cursusIds,
    required this.markedAt,
    required this.marked,
    required this.retriableAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProjectsUser.fromJson(Map<String, dynamic> json) => ProjectsUser(
    id: json["id"],
    occurrence: json["occurrence"],
    finalMark: json["final_mark"] ?? 0,
    status: statusValues.map[json["status"]]!,
    validated: json["validated?"] ?? false,
    currentTeamId: json["current_team_id"],
    project: Project.fromJson(json["project"]),
    cursusIds: List<int>.from(json["cursus_ids"].map((x) => x)),
    markedAt: json["marked_at"] ?? "",
    marked: json["marked"],
    retriableAt: json["retriable_at"] ?? "",
    createdAt: json["created_at"] ?? "",
    updatedAt: json["updated_at"] ?? "",
  );
}

class Project {
  int id;
  String name;
  String slug;
  int parentId;

  Project({
    required this.id,
    required this.name,
    required this.slug,
    required this.parentId,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    parentId: json["parent_id"] ?? 0,
  );
}

enum Status {
  FINISHED,
  IN_PROGRESS,
  SEARCHING_A_GROUP,
  WAITING_FOR_CORRECTION
}

final statusValues = EnumValues({
  "finished": Status.FINISHED,
  "in_progress": Status.IN_PROGRESS,
  "searching_a_group": Status.SEARCHING_A_GROUP,
  "waiting_for_correction": Status.WAITING_FOR_CORRECTION
});

class Title {
  int id;
  String name;

  Title({
    required this.id,
    required this.name,
  });

  factory Title.fromJson(Map<String, dynamic> json) => Title(
    id: json["id"],
    name: json["name"],
  );
}

class TitlesUser {
  int id;
  int userId;
  int titleId;
  bool selected;
  String createdAt;
  String updatedAt;

  TitlesUser({
    required this.id,
    required this.userId,
    required this.titleId,
    required this.selected,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TitlesUser.fromJson(Map<String, dynamic> json) => TitlesUser(
    id: json["id"],
    userId: json["user_id"],
    titleId: json["title_id"],
    selected: json["selected"],
    createdAt: json["created_at"] ?? "",
    updatedAt: json["updated_at"] ?? "",
  );
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
