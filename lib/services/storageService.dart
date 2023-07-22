import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'storageService.g.dart';

/// A service class for storing and retrieving data securely.
class StorageService {
  /// Initializes the shared preferences storage.
  ///
  /// Returns a [Future] that resolves to a [SharedPreferences] instance.
  Future<SharedPreferences> initStorage() async {
    return await SharedPreferences.getInstance();
  }

  /// Reads a string value from storage based on the specified [key].
  ///
  /// Returns a [Future] that resolves to the value associated with the key, or `null` if not found.
  Future<String?> readStringValueFromStorage({required String key}) async {
    SharedPreferences storage = await initStorage();
    try {
      return storage.getString(key);
    } catch (e) {
      storage.remove(key);
    }
    return null;
  }

  /// Reads an integer value from storage based on the specified [key].
  ///
  /// An optional [defaultValue] can be provided to return a default value if the key is not found or if an error occurs.
  ///
  /// Returns a [Future] that resolves to the integer value associated with the key, or the default value.
  Future<int?> readIntValueFromStorage({required String key, int defaultValue = 0}) async {
    SharedPreferences storage = await initStorage();
    try {
      return storage.getInt(key) ?? defaultValue;
    } catch (e) {
      storage.remove(key);
      return defaultValue;
    }
  }

  /// Writes a value to storage with the specified [key].
  ///
  /// The [value] must be a [String].
  Future<void> writeStringToStorage({required key, required String value}) async {
    SharedPreferences storage = await initStorage();
    await storage.setString(key, value);
  }

  /// Writes a value to storage with the specified [key].
  ///
  /// The [value] must be an [int].
  Future<void> writeIntToStorage({required key, required int value}) async {
    SharedPreferences storage = await initStorage();
    await storage.setInt(key, value);
  }

  /// Deletes the stored data associated with the specified [key].
  ///
  /// Returns a [Future] that resolves when the data is successfully deleted.
  Future<void> deleteStorageByKey({required key}) async {
    SharedPreferences storage = await initStorage();
    await storage.remove(key);
  }
}

@riverpod
StorageService storageService(StorageServiceRef ref) => StorageService();
