import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:laguna/constants.dart';

class StorageService {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  void saveTokens({required String accessToken, required String refreshToken}) {
    writeValueToStorage(key: Constants.accessTokenKey, value: accessToken);
    writeValueToStorage(key: Constants.refreshTokenKey, value: refreshToken);
  }

  Future<String> readStringValueFromStorage({required String key}) async {
    try {
      return await _storage.read(key: key) ?? "";
    } catch (e) {
      await _storage.delete(key: key);
      return "";
    }
  }

  Future<int> readIntValueFromStorage({required String key, int defaultValue = 0}) async {
    try {
      String value = await _storage.read(key: key) ?? "$defaultValue";
      return int.tryParse(value) ?? defaultValue;
    } catch (e) {
      await _storage.delete(key: key);
      return defaultValue;
    }
  }

  Future<void> writeValueToStorage({required key, required dynamic value}) async {
    await _storage.write(key: key, value: value.toString());
  }

  Future<void> deleteStorageByKey({required key}) async {
    await _storage.delete(key: key);
  }
}
