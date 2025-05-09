import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

/// A utility class to manage local storage of a user's custom avatar image.
///
/// This helper provides methods to:
/// - Save an avatar image locally and store its path in SharedPreferences.
/// - Load the stored avatar if it exists.
/// - Delete the stored avatar and its associated path.
/// - Retrieve the stored path directly.
///
/// The avatar is saved as 'avatar.png' in the app's documents directory.
/// This approach ensures persistence across sessions without using cloud storage.
class AvatarStorageHelper {
  static const _avatarFileName = 'avatar.png';
  static const _avatarPrefsKey = 'custom_avatar_path';

  /// Returns the [File] reference to the local avatar image file.
  static Future<File> _getLocalAvatarFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File(join(directory.path, _avatarFileName));
  }

  /// Saves the given [file] as the user's avatar image locally.
  ///
  /// Also stores its path in [SharedPreferences] for later retrieval.
  static Future<void> saveAvatar(File file) async {
    final avatarFile = await _getLocalAvatarFile();
    final saved = await file.copy(avatarFile.path);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_avatarPrefsKey, saved.path);
  }

  /// Loads the stored avatar file if it exists, otherwise returns null.
  ///
  /// Checks both the stored path and that the file actually exists on disk.
  static Future<File?> loadAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString(_avatarPrefsKey);

    if (savedPath == null) return null;
    final file = File(savedPath);
    return file.existsSync() ? file : null;
  }

  /// Deletes the stored avatar file and removes its path from preferences.
  static Future<void> deleteAvatar() async {
    final avatarFile = await _getLocalAvatarFile();
    if (await avatarFile.exists()) {
      await avatarFile.delete();
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_avatarPrefsKey);
  }

  /// Returns the stored path of the avatar image, if available.
  static Future<String?> getAvatarPath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_avatarPrefsKey);
  }
}
