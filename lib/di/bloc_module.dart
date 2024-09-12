import 'package:get_it/get_it.dart';
import 'package:klontong_project/features/bloc/product_bloc/product_bloc.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(() => ProductBloc(locator()));
}
