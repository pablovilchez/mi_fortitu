import 'package:mi_fortitu/features/profiles/domain/entities/project_user_entity.dart';

import 'cursus_user_entity.dart';

class UserEntity {
  int id;
  String email;
  String login;
  String firstName;
  String lastName;
  String profileUrl;
  String kind;
  ProfileImages image;
  bool staff;
  int correctionPoint;
  String poolMonth;
  String poolYear;
  int wallet;
  bool alumni;
  bool active;
  List<CursusUserEntity> cursusUsers;
  List<ProjectUserEntity> projectsUsers;
  List<Achievement> achievements;
  List<Title> titles;
  List<TitlesUser> titlesUsers;
  List<Campus> campus;
  List<CampusUser> campusUsers;

  UserEntity({
    required this.id,
    required this.email,
    required this.login,
    required this.firstName,
    required this.lastName,
    required this.profileUrl,
    required this.kind,
    required this.image,
    required this.staff,
    required this.correctionPoint,
    required this.poolMonth,
    required this.poolYear,
    required this.wallet,
    required this.alumni,
    required this.active,
    required this.cursusUsers,
    required this.projectsUsers,
    required this.achievements,
    required this.titles,
    required this.titlesUsers,
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
