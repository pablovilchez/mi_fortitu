import 'dart:io';
import 'package:flutter/foundation.dart';

class AvatarNotifier extends ValueNotifier<File?> {
  AvatarNotifier() : super(null);

  void update(File? newAvatar) {
    value = newAvatar;
  }
}

final avatarNotifier = AvatarNotifier();
