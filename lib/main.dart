import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mi_fortitu/core/helpers/preferences_helper.dart';
import 'package:mi_fortitu/core/router/app_router.dart';
import 'package:mi_fortitu/features/auth/presentation/bloc/supa_login_bloc/auth_bloc.dart';
import 'package:mi_fortitu/features/home/presentation/bloc/intra_events_bloc/intra_events_bloc.dart';
import 'package:mi_fortitu/features/home/presentation/bloc/intra_profile_bloc/intra_profile_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/di/dependency_injection.dart';
import 'features/home/presentation/bloc/intra_search_profile_bloc/intra_search_profile_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await PreferencesHelper().init();

  String savedLanguage = PreferencesHelper().getLanguage();
  await Supabase.initialize(url: dotenv.env['SUPA_URL']!, anonKey: dotenv.env['SUPA_ANON_KEY']!);
  initDi();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('es')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: Locale(savedLanguage),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => AuthBloc(
                authUsecase: sl(),
                dbLogInUsecase: sl(),
                dbRegisterUsecase: sl(),
                getRoleUseCase: sl(),
              ),
        ),
        BlocProvider(create: (_) => IntraProfileBloc(getProfileUsecase: sl())),
        BlocProvider(create: (_) => IntraSearchProfileBloc(getProfileUsecase: sl())),
        BlocProvider(create: (_) => IntraEventsBloc(getEventsUsecase: sl())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        routerConfig: appRouter,
      ),
    );
  }
}
