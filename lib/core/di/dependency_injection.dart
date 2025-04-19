import 'package:app_links/app_links.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
// Helpers and services
import 'package:mi_fortitu/core/config/env_config.dart';
import 'package:mi_fortitu/core/helpers/secure_storage_helper.dart';
import 'package:mi_fortitu/core/services/intra_api_client.dart';
import 'package:mi_fortitu/core/services/url_launcher_service.dart';
// Features
import 'package:mi_fortitu/features/access/auth.dart';
import 'package:mi_fortitu/features/clusters/clusters.dart';
import 'package:mi_fortitu/features/coalitions_blocs/coalitions_blocs.dart';
import 'package:mi_fortitu/features/home/home.dart';
import 'package:mi_fortitu/features/peers/peers.dart';
import 'package:mi_fortitu/features/profiles/profiles.dart';
// Database package helper
import 'package:supabase_flutter/supabase_flutter.dart';

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
  sl.registerLazySingleton<IntraApiClient>(() => IntraApiClient(sl(), sl(), sl()));
  sl.registerLazySingleton<UrlLauncherService>(() => UrlLauncherServiceImpl());

  // Auth feature - Datasources
  sl.registerLazySingleton<AccessSupaDatasource>(() => AccessSupaDatasource(supabaseClient));
  sl.registerLazySingleton<AccessIntraDatasource>(() => AccessIntraDatasource(sl(), sl(), sl(), sl()));
  // Auth feature - Repositories
  sl.registerLazySingleton<AccessIntraRepository>(() => AccessIntraRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<AccessDbRepository>(() => AccessDbRepositoryImpl(sl()));
  // Auth feature - Usecases
  sl.registerLazySingleton<AuthUsecase>(() => AuthUsecase(sl(), sl()));
  sl.registerLazySingleton<GetRoleUsecase>(() => GetRoleUsecase(sl()));
  sl.registerLazySingleton<DbLogInUsecase>(() => DbLogInUsecase(sl()));
  sl.registerLazySingleton<DbRegisterUsecase>(() => DbRegisterUsecase(sl()));
  // Auth feature - Blocs
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(sl(), sl(), sl(), sl()));

  // Clusters feature - Datasources
  sl.registerLazySingleton<ClustersDatasource>(() => ClustersDatasource(sl(), sl()));
  // Clusters feature - Repositories
  sl.registerLazySingleton<ClustersRepository>(() => ClustersRepositoryImpl(sl()));
  // Clusters feature - Usecases
  sl.registerLazySingleton<GetClustersUsecase>(() => GetClustersUsecase(sl()));
  // Clusters feature - Blocs
  sl.registerLazySingleton<ClustersBloc>(() => ClustersBloc(sl()));

  // Coalitions Blocs feature - Datasources
  sl.registerLazySingleton<CoalitionsBlocsDatasource>(() => CoalitionsBlocsDatasource(sl(), sl()));
  // Coalitions Blocs feature - Repositories
  sl.registerLazySingleton<CoalitionsBlocsRepository>(() => CoalitionsBlocsRepositoryImpl(sl()));
  // Coalitions Blocs feature - Usecases
  sl.registerLazySingleton<GetCoalitionsBlocsUsecase>(() => GetCoalitionsBlocsUsecase(sl()));
  // Coalitions Blocs feature - Blocs
  sl.registerLazySingleton<CoalitionsBlocsBloc>(() => CoalitionsBlocsBloc(sl()));

  // Home feature - Datasources
  sl.registerLazySingleton<HomeDatasource>(() => HomeDatasource(sl(), sl()));
  // Home feature - Repositories
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));
  // Home feature - Use cases
  sl.registerLazySingleton<GetEventsUsecase>(() => GetEventsUsecase(sl()));
  // Home feature - Blocs
  sl.registerLazySingleton<EventsBloc>(() => EventsBloc(sl()));

  // Peers feature - Datasources
  sl.registerLazySingleton<PeersDatasource>(() => PeersDatasource(sl(), sl()));
  // Peers feature - Repositories
  sl.registerLazySingleton<PeersRepository>(() => PeersRepositoryImpl(sl()));
  // Peers feature - Use cases
  sl.registerLazySingleton<GetProjectUsersUseCase>(() => GetProjectUsersUseCase(sl()));
  // Peers feature - Blocs
  sl.registerLazySingleton<ProjectsBloc>(() => ProjectsBloc(sl()));

  // Profile feature - Datasources
  sl.registerLazySingleton<ProfilesDatasource>(() => ProfilesDatasource(sl(), sl()));
  // Profile feature - Repositories
  sl.registerLazySingleton<ProfilesRepository>(() => ProfilesRepositoryImpl(sl()));
  // Profile feature - Use cases
  sl.registerLazySingleton<GetProfileUsecase>(() => GetProfileUsecase(sl()));
  // Profile feature - Blocs
  sl.registerLazySingleton<UserBloc>(() => UserBloc(sl()));
  sl.registerLazySingleton<SearchBloc>(() => SearchBloc(sl()));
}
