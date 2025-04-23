import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class AvatarStorageHelper {
  static const _avatarFileName = 'avatar.png';
  static const _avatarPrefsKey = 'custom_avatar_path';

  static Future<File> _getLocalAvatarFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File(join(directory.path, _avatarFileName));
  }

  static Future<void> saveAvatar(File file) async {
    final avatarFile = await _getLocalAvatarFile();
    final saved = await file.copy(avatarFile.path);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_avatarPrefsKey, saved.path);
  }

  static Future<File?> loadAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString(_avatarPrefsKey);

    if (savedPath == null) return null;
    final file = File(savedPath);
    return file.existsSync() ? file : null;
  }

  static Future<void> deleteAvatar() async {
    final avatarFile = await _getLocalAvatarFile();
    if (await avatarFile.exists()) {
      await avatarFile.delete();
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_avatarPrefsKey);
  }

  static Future<String?> getAvatarPath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_avatarPrefsKey);
  }
}
