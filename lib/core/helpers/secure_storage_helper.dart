import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// A helper class for secure storage operations.
///
/// This class provides methods to save, read, and delete values in secure storage.
class SecureStorageHelper {
  final FlutterSecureStorage _storage;

  SecureStorageHelper(this._storage);

  /// Saves a value in secure storage.
  Future<void> save(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Reads a value from secure storage.
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// Deletes a value from secure storage.
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }
}
