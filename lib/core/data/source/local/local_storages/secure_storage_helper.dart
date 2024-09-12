import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  final FlutterSecureStorage storage;
  SecureStorageHelper({required this.storage});

  Future<void> addItemToSecureStorage(String key, dynamic value) {
    return storage.write(key: key, value: value);
  }

  Future<String?> loadItemFromSecureStorage(String key) {
    return storage.read(key: key);
  }

  Future<void> removeItemFromSecureStorage(String key) {
    return storage.delete(key: key);
  }
}

class SecureStorageKeys {
  static const userAccessToken = 'user_access_token';
}
