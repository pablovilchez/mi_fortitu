import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_fortitu/core/helpers/secure_storage_helper.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late SecureStorageHelper secureStorageHelper;
  late MockFlutterSecureStorage mockStorage;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    secureStorageHelper = SecureStorageHelper(mockStorage);
  });

  group('SecureStorageHelper', () {
    test('save() should save the value in secure storage', () async {
      // Arrange
      const key = 'test_key';
      const value = 'test_value';
      when(() => mockStorage.write(key: key, value: value)).thenAnswer((_) async => {});

      // Act
      await secureStorageHelper.save(key, value);

      // Assert
      verify(() => mockStorage.write(key: key, value: value)).called(1);
    });

    test('read() should return the value from secure storage', () async {
      // Arrange
      const key = 'test_key';
      const value = 'test_value';
      when(() => mockStorage.read(key: key)).thenAnswer((_) async => value);

      // Act
      final result = await secureStorageHelper.read(key);

      // Assert
      expect(result, value);
      verify(() => mockStorage.read(key: key)).called(1);
    });

    test('read() should return null if key does not exist', () async {
      // Arrange
      const key = 'non_existing_key';
      when(() => mockStorage.read(key: key)).thenAnswer((_) async => null);

      // Act
      final result = await secureStorageHelper.read(key);

      // Assert
      expect(result, isNull);
      verify(() => mockStorage.read(key: key)).called(1);
    });

    test('delete() should delete the value from secure storage', () async {
      // Arrange
      const key = 'test_key';
      when(() => mockStorage.delete(key: key)).thenAnswer((_) async => {});

      // Act
      await secureStorageHelper.delete(key);

      // Assert
      verify(() => mockStorage.delete(key: key)).called(1);
    });
  });
}
