import 'package:localstorage/localstorage.dart';

class LocalStorageHelper {
  final LocalStorage storage;
  LocalStorageHelper({required this.storage});

  void addItemToLocalStorage(String key, dynamic value) {
    storage.setItem(key, value);
  }

  dynamic loadItemFromLocalStorage(String key) {
    return storage.getItem(key);
  }

  void removeItemFromLocalStorage(String key) {
    storage.removeItem(key);
  }
}

class LocalStorageKeys {}
