class IntraProfile {
  int id;
  String email;
  String login;
  String firstName;
  String lastName;
  String usualFullName;
  String usualFirstName;
  String profileUrl;
  String displayName;
  String kind;
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

  IntraProfile({
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
}

class ProfileImages {
  String link;
  Versions versions;

  ProfileImages({
    required this.link,
    required this.versions,
  });
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
}

class ProjectsUser {
  int id;
  int occurrence;
  int finalMark;
  String status;
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
}

class Achievement {
  int id;
  String name;
  String description;
  String tier;
  String kind;
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
}

class Title {
  int id;
  String name;

  Title({
    required this.id,
    required this.name,
  });
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
}

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
}

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
}
