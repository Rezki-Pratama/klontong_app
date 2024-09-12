import 'package:get_it/get_it.dart';
import 'package:klontong_project/core/domains/usecase/product_use_case.dart';

final locator = GetIt.instance;

void init() {
  locator.registerLazySingleton(() => ProductUseCase(locator()));
}
