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
import 'package:mi_fortitu/features/access/access.dart';
import 'package:mi_fortitu/features/clusters/clusters.dart';
import 'package:mi_fortitu/features/coalitions_blocs/coalitions_blocs.dart';
import 'package:mi_fortitu/features/home/home.dart';
import 'package:mi_fortitu/features/peers/peers.dart';
import 'package:mi_fortitu/features/profiles/profiles.dart';
import 'package:mi_fortitu/features/settings/settings.dart';
import 'package:mi_fortitu/features/slots/slots.dart';
// Database package helper
import 'package:supabase_flutter/supabase_flutter.dart';

// Environment
final GetIt sl = GetIt.instance;
final SupabaseClient supabaseClient = Supabase.instance.client;

/// Initializes the application's dependency injection using GetIt.
///
/// Registers all external services, environment configurations, helpers, and
/// feature-specific layers (data sources, repositories, use cases, and BLoCs).
///
/// This function should be called once during app startup,
/// before using any of the registered services or features.
void initDi() {
  // ─── External Dependencies ──────────────────────────────────────────────
  sl.registerLazySingleton<SupabaseClient>(() => supabaseClient);
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<AppLinks>(() => AppLinks());

  // ─── Core Config & Services ─────────────────────────────────────────────
  sl.registerLazySingleton<EnvConfig>(() => EnvConfig.from(dotenv.env));
  sl.registerLazySingleton<SecureStorageHelper>(() => SecureStorageHelper(const FlutterSecureStorage()));
  sl.registerLazySingleton<IntraApiClient>(() => IntraApiClient(sl(), sl(), sl(), sl(), sl()));
  sl.registerLazySingleton<UrlLauncherService>(() => UrlLauncherServiceImpl());

  // ─── Auth Feature (Access) ──────────────────────────────────────────────
  sl.registerLazySingleton<AccessDatasource>(() => AccessDatasource(sl()));
  sl.registerLazySingleton<AccessRepository>(() => AccessRepositoryImpl(sl()));
  sl.registerLazySingleton<AuthUsecase>(() => AuthUsecase(sl()));
  sl.registerLazySingleton<GetRoleUsecase>(() => GetRoleUsecase(sl()));
  sl.registerLazySingleton<LogInUsecase>(() => LogInUsecase(sl()));
  sl.registerLazySingleton<RegisterUsecase>(() => RegisterUsecase(sl()));
  sl.registerLazySingleton<RequestAccountRecoveryEmailUsecase>(() => RequestAccountRecoveryEmailUsecase(sl()));
  sl.registerLazySingleton<SetNewPasswordUsecase>(() => SetNewPasswordUsecase(sl()));
  sl.registerLazySingleton<AccessBloc>(() => AccessBloc(sl(), sl(), sl(), sl(), sl(), sl()));

  // ─── Clusters Feature ───────────────────────────────────────────────────
  sl.registerLazySingleton<ClustersDatasource>(() => ClustersDatasource(sl(), sl()));
  sl.registerLazySingleton<ClustersRepository>(() => ClustersRepositoryImpl(sl()));
  sl.registerLazySingleton<GetClustersUsecase>(() => GetClustersUsecase(sl()));
  sl.registerLazySingleton<ClustersBloc>(() => ClustersBloc(sl()));

  // ─── Coalitions Blocs Feature ──────────────────────────────────────────
  sl.registerLazySingleton<CoalitionsBlocsDatasource>(() => CoalitionsBlocsDatasource(sl(), sl()));
  sl.registerLazySingleton<CoalitionsBlocsRepository>(() => CoalitionsBlocsRepositoryImpl(sl()));
  sl.registerLazySingleton<GetCoalitionsBlocsUsecase>(() => GetCoalitionsBlocsUsecase(sl()));
  sl.registerLazySingleton<CoalitionsBlocsBloc>(() => CoalitionsBlocsBloc(sl()));

  // ─── Home Feature ───────────────────────────────────────────────────────
  sl.registerLazySingleton<HomeDatasource>(() => HomeDatasource(sl(), sl()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));
  sl.registerLazySingleton<GetEventsUsecase>(() => GetEventsUsecase(sl()));
  sl.registerLazySingleton<SubscribeEventUsecase>(() => SubscribeEventUsecase(sl()));
  sl.registerLazySingleton<UnsubscribeEventUsecase>(() => UnsubscribeEventUsecase(sl()));
  sl.registerLazySingleton<EventsBloc>(() => EventsBloc(sl(), sl(), sl()));

  // ─── Peers Feature ──────────────────────────────────────────────────────
  sl.registerLazySingleton<PeersDatasource>(() => PeersDatasource(sl(), sl()));
  sl.registerLazySingleton<PeersRepository>(() => PeersRepositoryImpl(sl()));
  sl.registerLazySingleton<GetProjectsPeersUsecase>(() => GetProjectsPeersUsecase(sl()));

  // ─── Profile Feature ────────────────────────────────────────────────────
  sl.registerLazySingleton<ProfilesDatasource>(() => ProfilesDatasource(sl(), sl()));
  sl.registerLazySingleton<ProfilesRepository>(() => ProfilesRepositoryImpl(sl()));
  sl.registerLazySingleton<GetProfileUsecase>(() => GetProfileUsecase(sl()));
  sl.registerLazySingleton<UserProfileBloc>(() => UserProfileBloc(sl()));

  // ─── Settings Feature ───────────────────────────────────────────────────
  sl.registerLazySingleton<SettingsDatasource>(() => SettingsDatasource(sl()));
  sl.registerLazySingleton<SettingsRepository>(() => SettingsRepositoryImpl(sl()));
  sl.registerLazySingleton<LogoutUsecase>(() => LogoutUsecase(sl(), sl()));

  // ─── Slots Feature ──────────────────────────────────────────────────────
  sl.registerLazySingleton<SlotsDatasource>(() => SlotsDatasource(sl(), sl()));
  sl.registerLazySingleton<SlotsRepository>(() => SlotsRepositoryImpl(sl()));
  sl.registerLazySingleton<GetUserOpenSlotsUsecase>(() => GetUserOpenSlotsUsecase(sl()));
  sl.registerLazySingleton<CreateNewSlotUsecase>(() => CreateNewSlotUsecase(sl()));
  sl.registerLazySingleton<DestroySlotsUsecase>(() => DestroySlotsUsecase(sl()));
  sl.registerLazySingleton<SlotsBloc>(() => SlotsBloc(sl(), sl(), sl()));
}
