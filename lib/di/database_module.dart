import 'package:get_it/get_it.dart';
import 'package:klontong_project/core/data/source/local/floor/app_database/database.dart';
import 'package:klontong_project/core/data/source/local/floor/dao/product_dao.dart';
import 'package:localstorage/localstorage.dart';
import 'package:klontong_project/core/data/source/local/local_storages/local_storage_helper.dart';
import 'package:klontong_project/core/data/source/local/local_storages/secure_storage_helper.dart';
import 'package:klontong_project/core/data/source/local/preferences/shared_preferences_helper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final locator = GetIt.instance;

Future init() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('clock_database.db').build();

  final productDao = database.productDao;

  locator.registerSingleton<ProductDao>(productDao);

  // local storage
  locator.registerLazySingleton<LocalStorageHelper>(
      () => LocalStorageHelper(storage: locator()));
  locator.registerLazySingleton<LocalStorage>(() => localStorage);

  // secure storage
  locator.registerLazySingleton<SecureStorageHelper>(
      () => SecureStorageHelper(storage: locator()));
  locator.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());

  // shared preference
  locator.registerLazySingleton<SharedPreferencesHelper>(
      () => SharedPreferencesHelper());
}
