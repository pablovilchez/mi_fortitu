import 'package:app_links/app_links.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
// Helpers and services
import 'package:mi_fortitu/core/helpers/secure_storage_helper.dart';
import 'package:mi_fortitu/core/services/intra_api_client.dart';
import 'package:mi_fortitu/core/services/url_launcher_service.dart';
// Auth feature
import 'package:mi_fortitu/features/auth/data/datasources/datasources.dart';
import 'package:mi_fortitu/features/auth/data/repositories/repositories.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/repositories.dart';
import 'package:mi_fortitu/features/auth/domain/usecases/db_get_role_usecase.dart';
import 'package:mi_fortitu/features/auth/domain/usecases/usecases.dart';
import 'package:mi_fortitu/features/auth/presentation/bloc/supa_login_bloc/auth_bloc.dart';
// Home feature
import 'package:mi_fortitu/features/home/data/datasources/home_intra_datasource.dart';
import 'package:mi_fortitu/features/home/domain/usecases/get_clusters_usecase.dart';
import 'package:mi_fortitu/features/home/presentation/bloc/intra_events_bloc/intra_events_bloc.dart';
import 'package:mi_fortitu/features/home/presentation/bloc/intra_profile_bloc/intra_profile_bloc.dart';
import 'package:mi_fortitu/features/home/presentation/bloc/intra_search_profile_bloc/intra_search_profile_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/home/data/repositories/home_intra_repository_impl.dart';
import '../../features/home/domain/repositories/home_intra_repository.dart';
import '../../features/home/domain/usecases/get_coalitions_usecase.dart';
import '../../features/home/domain/usecases/get_events_usecase.dart';
import '../../features/home/domain/usecases/get_profile_usecase.dart';
import '../../features/home/presentation/bloc/intra_clusters_bloc/intra_clusters_bloc.dart';
import '../../features/home/presentation/bloc/intra_coalitions_bloc/intra_coalitions_bloc.dart';
import '../config/env_config.dart';

// Environment
final GetIt sl = GetIt.instance;
final SupabaseClient supabaseClient = Supabase.instance.client;

/// Initialize the dependency injection
void initDi() {
  // External dependencies
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<AppLinks>(() => AppLinks());

  // Environment variables
  sl.registerLazySingleton<EnvConfig>(() => EnvConfig.from(dotenv.env));

  // Helpers and services
  sl.registerLazySingleton<SecureStorageHelper>(() => SecureStorageHelper(FlutterSecureStorage()));
  sl.registerLazySingleton<IntraApiClient>(
    () => IntraApiClient(httpClient: sl(), env: sl(), secureStorage: sl()),
  );
  sl.registerLazySingleton<UrlLauncherService>(() => UrlLauncherServiceImpl());

  // Auth feature - Datasources
  sl.registerLazySingleton<AuthSupaDatasource>(() => AuthSupaDatasource(supabaseClient));
  sl.registerLazySingleton<AuthIntraDatasource>(
    () => AuthIntraDatasource(httpClient: sl(), appLinks: sl(), launcher: sl(), env: sl()),
  );
  // Auth feature - Repositories
  sl.registerLazySingleton<AuthIntraRepository>(
    () => AuthIntraRepositoryImpl(sl<AuthIntraDatasource>(), sl<IntraApiClient>()),
  );
  sl.registerLazySingleton<AuthDbRepository>(() => AuthDbRepositoryImpl(sl<AuthSupaDatasource>()));
  // Auth feature - Usecases
  sl.registerLazySingleton<AuthUsecase>(() => AuthUsecase(sl(), sl()));
  sl.registerLazySingleton<DbLogInUsecase>(() => DbLogInUsecase(sl()));
  sl.registerLazySingleton<DbRegisterUsecase>(() => DbRegisterUsecase(sl()));
  sl.registerLazySingleton<GetRoleUsecase>(() => GetRoleUsecase(sl()));

  // Auth feature - Blocs
  sl.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      authUsecase: sl(),
      dbLogInUsecase: sl(),
      dbRegisterUsecase: sl(),
      getRoleUseCase: sl(),
    ),
  );

  // Home feature - Datasources
  sl.registerLazySingleton<HomeIntraDatasource>(
    () => HomeIntraDatasource(httpClient: sl(), intraApiClient: sl()),
  );
  // Home feature - Repositories
  sl.registerLazySingleton<HomeIntraRepository>(
    () => HomeIntraRepositoryImpl(sl<HomeIntraDatasource>()),
  );

  // Home feature - Use cases
  sl.registerLazySingleton<GetEventsUsecase>(() => GetEventsUsecase(repository: sl()));
  sl.registerLazySingleton<GetProfileUsecase>(() => GetProfileUsecase(repository: sl()));
  sl.registerLazySingleton<GetClustersUsecase>(() => GetClustersUsecase(sl()));
  sl.registerLazySingleton<GetCoalitionsUsecase>(() => GetCoalitionsUsecase(sl()));

  // Home feature - Blocs
  sl.registerLazySingleton<IntraEventsBloc>(() => IntraEventsBloc(getEventsUsecase: sl()));
  sl.registerLazySingleton<IntraProfileBloc>(() => IntraProfileBloc(getProfileUsecase: sl()));
  sl.registerLazySingleton<IntraSearchProfileBloc>(
    () => IntraSearchProfileBloc(getProfileUsecase: sl()),
  );
  sl.registerLazySingleton<IntraClustersBloc>(
    () => IntraClustersBloc(getCampusClustersUsecase: sl()),
  );
  sl.registerLazySingleton<IntraCoalitionsBloc>(
    () => IntraCoalitionsBloc(getCoalitionsUsecase: sl()),
  );
}
