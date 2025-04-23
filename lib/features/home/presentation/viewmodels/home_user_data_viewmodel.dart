import 'package:mi_fortitu/features/profiles/domain/entities/cursus_user_entity.dart';

import '../../../profiles/domain/entities/user_entity.dart';

class HomeUserDataVm {
  final String loginName;
  final String name;
  final String customAvatar;
  final String intraAvatar;
  final int level;
  final int rank;
  final int evalPoints;
  final int wallet;
  final bool isMainCursus;

  const HomeUserDataVm({
    required this.loginName,
    required this.name,
    required this.customAvatar,
    required this.intraAvatar,
    required this.level,
    required this.rank,
    required this.evalPoints,
    required this.wallet,
    this.isMainCursus = false,
  });

  factory HomeUserDataVm.fromEntity(UserEntity entity) {
    final CursusUserEntity cursus = entity.cursusUsers.firstWhere(
      (cursus) => cursus.cursus.kind == 'main',
      orElse: () => entity.cursusUsers.first,
    );
    bool isMainCursus = cursus.cursus.kind == 'main';

    return HomeUserDataVm(
      loginName: entity.login,
      name: entity.firstName,
      customAvatar: 'assets/images/default_avatar.png',
      intraAvatar: entity.image.versions.small,
      level: isMainCursus ? cursus.level.truncate() : 0,
      rank: 0,
      evalPoints: entity.correctionPoint,
      wallet: entity.wallet,
    );
  }

  factory HomeUserDataVm.empty() {
    return const HomeUserDataVm(
      loginName: '',
      name: '',
      customAvatar: 'assets/images/default_avatar.png',
      intraAvatar: 'assets/images/default_avatar.png',
      level: 0,
      rank: 0,
      evalPoints: 0,
      wallet: 0,
    );
  }

  HomeUserDataVm copyWith({
    String? loginName,
    String? name,
    String? customAvatar,
    String? intraAvatar,
    int? level,
    int? rank,
    int? evalPoints,
    int? wallet,
    bool? isMainCursus,
  }) {
    return HomeUserDataVm(
      loginName: loginName ?? this.loginName,
      name: name ?? this.name,
      customAvatar: customAvatar ?? this.customAvatar,
      intraAvatar: intraAvatar ?? this.intraAvatar,
      level: level ?? this.level,
      rank: rank ?? this.rank,
      evalPoints: evalPoints ?? this.evalPoints,
      wallet: wallet ?? this.wallet,
      isMainCursus: isMainCursus ?? this.isMainCursus,
    );
  }

}