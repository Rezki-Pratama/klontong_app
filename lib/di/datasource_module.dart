import 'package:get_it/get_it.dart';
import 'package:klontong_project/core/data/source/remote_datasources/product_remote_datasource/product_datasource.dart';
import 'package:klontong_project/core/data/source/remote_datasources/product_remote_datasource/product_datasource_impl.dart';

final locator = GetIt.instance;

init() {
  locator.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(apiBaseHelper: locator()),
  );
}
