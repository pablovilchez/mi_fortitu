import 'package:get_it/get_it.dart';
import 'package:mi_fortitu/features/auth/data/datasources/auth_intra_datasource.dart';
import 'package:mi_fortitu/features/auth/data/datasources/auth_supa_datasource.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_intra_repository.dart';
import 'package:mi_fortitu/features/auth/domain/usecases/check_profile_credentials_usecase.dart';
import 'package:mi_fortitu/features/auth/domain/usecases/get_intra_client_usecase.dart';
import 'package:mi_fortitu/features/auth/domain/usecases/get_role_usecase.dart';
import 'package:mi_fortitu/features/auth/presentation/bloc/intra_login_cubit/intra_login_cubit.dart';
import 'package:mi_fortitu/features/auth/presentation/bloc/supa_login_bloc/supa_login_bloc.dart';

import '../../features/auth/data/repositories/auth_intra_repository_impl.dart';
import '../../features/auth/data/repositories/auth_supa_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_supa_repository.dart';
import '../../features/auth/domain/usecases/log_in_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';

final GetIt sl = GetIt.instance;

/// Initialize the dependency injection
void initDi() {
  // External dependencies
  sl.registerLazySingleton<AuthIntraDatasource>(() => AuthIntraDatasource());
  sl.registerLazySingleton<AuthSupaDatasource>(() => AuthSupaDatasource());

  // Repositories
  sl.registerLazySingleton<AuthIntraRepository>(() => AuthIntraRepositoryImpl(sl()));
  sl.registerLazySingleton<AuthSupaRepository>(() => AuthSupaRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton<LogInUsecase>(() => LogInUsecase(sl()));
  sl.registerLazySingleton<RegisterUsecase>(() => RegisterUsecase(sl()));
  sl.registerLazySingleton<GetRoleUseCase>(() => GetRoleUseCase(sl()));
  sl.registerLazySingleton<GetIntraClientUsecase>(() => GetIntraClientUsecase(sl()));
  sl.registerLazySingleton<CheckProfileCredentialsUsecase>(
    () => CheckProfileCredentialsUsecase(sl()),
  );
  // sl.registerLazySingleton<LogOutUsecase>(() => LogOutUsecase(sl()));

  // Blocs
  sl.registerLazySingleton<IntraLoginCubit>(() => IntraLoginCubit(intraGetClient: sl()));
  sl.registerLazySingleton<SupaLoginBloc>(
    () => SupaLoginBloc(
      intraGetClient: sl(),
      getRoleUseCase: sl(),
      logInUsecase: sl(),
      registerUsecase: sl(),
      checkProfileCredentialsUsecase: sl(),
    ),
  );
}
