import 'package:alice/alice.dart';

import 'package:get_it/get_it.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

import 'package:klontong_project/core/data/source/remote/api_base_helper.dart';
import 'package:klontong_project/core/data/source/remote/auth_interceptor.dart';
import 'package:klontong_project/core/data/source/remote/log_interceptor.dart';
import 'package:http/http.dart' as http;

import '../di/database_module.dart' as database_module;
import '../di/datasource_module.dart' as datasource_module;
import '../di/repository_module.dart' as repository_module;
import '../di/usecase_module.dart' as usecase_module;
import '../di/bloc_module.dart' as bloc_module;

final locator = GetIt.instance;

init() async {
  await database_module.init();
  datasource_module.init();
  repository_module.init();
  usecase_module.init();
  bloc_module.init();

  // remote service
  locator.registerLazySingleton<InterceptedClient>(() =>
      InterceptedClient.build(
          interceptors: [AuthInterceptor(), LogInterceptor()]));
  locator.registerLazySingleton<ApiBaseHelper>(
    () => ApiBaseHelper(client: locator(), networkInspector: locator()),
  );

  locator.registerLazySingleton(() => http.Client());

  // Network inspector tool
  locator.registerLazySingleton<Alice>(
      () => Alice(showNotification: true, showInspectorOnShake: true));
}
