class BlocEntity {
  final int id;
  final int campusId;
  final int cursusId;
  final List<CoalitionEntity> coalitions;

  BlocEntity({
    required this.id,
    required this.campusId,
    required this.cursusId,
    required this.coalitions,
  });
}

class CoalitionEntity {
  final int id;
  final String name;
  final String slug;
  final String imageUrl;
  final String coverUrl;
  final String color;
  final int score;
  final int userId;

  CoalitionEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.imageUrl,
    required this.coverUrl,
    required this.color,
    required this.score,
    required this.userId,
  });
}