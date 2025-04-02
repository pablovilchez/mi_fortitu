import 'package:app_links/app_links.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mi_fortitu/features/auth/data/datasources/auth_intra_datasource.dart';
import 'package:mi_fortitu/features/auth/data/datasources/auth_supa_datasource.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_intra_repository.dart';
import 'package:mi_fortitu/features/auth/domain/usecases/usecases.dart';
import 'package:mi_fortitu/features/auth/presentation/bloc/intra_login_cubit/intra_login_cubit.dart';
import 'package:mi_fortitu/features/auth/presentation/bloc/supa_login_bloc/supa_login_bloc.dart';

import '../../features/auth/data/repositories/auth_intra_repository_impl.dart';
import '../../features/auth/data/repositories/auth_supa_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_supa_repository.dart';
import '../../features/home/data/datasources/home_intra_datasource.dart';
import '../helpers/secure_storage_helper.dart';
import '../services/intra_api_service.dart';
import '../services/url_launcher_service.dart';

final GetIt sl = GetIt.instance;

/// Initialize the dependency injection
void initDi() {
  // External dependencies
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<AppLinks>(() => AppLinks());
  sl.registerLazySingleton<SecureStorageHelper>(() => SecureStorageHelper(FlutterSecureStorage()));

  // Datasources
  sl.registerLazySingleton<AuthSupaDatasource>(() => AuthSupaDatasource());
  sl.registerLazySingleton<AuthIntraDatasource>(
    () => AuthIntraDatasource(httpClient: sl(), appLinks: sl(), launcher: sl(), env: sl()),
  );
  sl.registerLazySingleton<HomeIntraDatasource>(
    () => HomeIntraDatasource(httpClient: sl(), intraApiService: sl()),
  );

  // Services
  sl.registerLazySingleton<IntraApiService>(
    () => IntraApiService(httpClient: sl(), env: sl(), secureStorage: sl()),
  );
  sl.registerLazySingleton<UrlLauncherService>(() => UrlLauncherServiceImpl());

  // Repositories
  sl.registerLazySingleton<AuthIntraRepository>(
    () => AuthIntraRepositoryImpl(sl<AuthIntraDatasource>(), sl<IntraApiService>()),
  );
  sl.registerLazySingleton<AuthSupaRepository>(
    () => AuthSupaRepositoryImpl(sl<AuthSupaDatasource>()),
  );

  // Use cases
  sl.registerLazySingleton<LogInUsecase>(() => LogInUsecase(sl()));
  sl.registerLazySingleton<RegisterUsecase>(() => RegisterUsecase(sl()));
  sl.registerLazySingleton<GetRoleUseCase>(() => GetRoleUseCase(sl()));
  sl.registerLazySingleton<IntraAuthUsecase>(
    () => IntraAuthUsecase(sl<AuthIntraRepository>(), sl<SecureStorageHelper>()),
  );
  sl.registerLazySingleton<CheckProfileCredentialsUsecase>(
    () => CheckProfileCredentialsUsecase(sl()),
  );

  // Blocs
  sl.registerLazySingleton<IntraLoginCubit>(
    () => IntraLoginCubit(intraAuthUsecase: sl()),
  );
  sl.registerLazySingleton<SupaLoginBloc>(
    () => SupaLoginBloc(
      intraAuthUsecase: sl(),
      getRoleUsecase: sl(),
      logInUsecase: sl(),
      registerUsecase: sl(),
      checkProfileCredentialsUsecase: sl(),
    ),
  );
}
