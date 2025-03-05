import 'package:mi_fortitu/features/home/domain/entities/intra_profile.dart';

class ProfileSummaryVM {
  final String name;
  final String title;
  final String cursus;
  final String grade;
  final double level;
  final String imageUrl;
  final String coalitionImageUrl;
  final int correctionPoints;
  final int wallet;

  ProfileSummaryVM({
    required this.name,
    required this.title,
    required this.cursus,
    required this.grade,
    required this.level,
    required this.imageUrl,
    required this.coalitionImageUrl,
    required this.correctionPoints,
    required this.wallet,
  });

  factory ProfileSummaryVM.fromEntity(IntraProfile entity) {
    late final String titleFound;
    late final CursusUser findCursus;

    try {
      final titleId = entity.titlesUsers.firstWhere((e) => e.selected).titleId;
      titleFound = entity.titles
          .firstWhere((e) => e.id == titleId)
          .name
          .replaceAll('%login', entity.login);
    } catch (e) {
      titleFound = entity.login;
    }

    try {
      findCursus = entity.cursusUsers.firstWhere(
            (e) => e.cursus.kind == 'main',
      );
    } catch (e) {
      findCursus = entity.cursusUsers.first;
    }

    return ProfileSummaryVM(
      name: entity.firstName,
      title: titleFound,
      cursus: findCursus.cursus.name,
      grade: findCursus.grade,
      level: findCursus.level,
      imageUrl: entity.image.versions.small,
      coalitionImageUrl: 'assets/images/default_coalition.png',
      correctionPoints: entity.correctionPoint,
      wallet: entity.wallet,
    );
  }
}