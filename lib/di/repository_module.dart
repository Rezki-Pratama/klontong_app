import 'package:get_it/get_it.dart';
import 'package:klontong_project/core/data/repository/product_repository/product_repository_impl.dart';
import 'package:klontong_project/core/domains/repository/product_repository.dart';

final locator = GetIt.instance;

void init() {
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );
}
