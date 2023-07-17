import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storageService.g.dart';

/// A service class for storing and retrieving data securely.
class StorageService {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  /// Reads a string value from storage based on the specified [key].
  ///
  /// Returns a [Future] that resolves to the value associated with the key, or `null` if not found.
  Future<String?> readStringValueFromStorage({required String key}) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      await _storage.delete(key: key);
    }
    return null;
  }

  /// Reads an integer value from storage based on the specified [key].
  ///
  /// An optional [defaultValue] can be provided to return a default value if the key is not found or if an error occurs.
  ///
  /// Returns a [Future] that resolves to the integer value associated with the key, or the default value.
  Future<int> readIntValueFromStorage({required String key, int defaultValue = 0}) async {
    try {
      String value = await _storage.read(key: key) ?? "$defaultValue";
      return int.tryParse(value) ?? defaultValue;
    } catch (e) {
      await _storage.delete(key: key);
      return defaultValue;
    }
  }

  /// Writes a value to storage with the specified [key].
  ///
  /// The [value] can be of any type.
  Future<void> writeValueToStorage({required key, required dynamic value}) async {
    await _storage.write(key: key, value: value.toString());
  }

  /// Deletes the stored data associated with the specified [key].
  Future<void> deleteStorageByKey({required key}) async {
    await _storage.delete(key: key);
  }
}

@riverpod
StorageService storageService(StorageServiceRef ref) => StorageService();
