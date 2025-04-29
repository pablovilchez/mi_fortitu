import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mi_fortitu/core/helpers/preferences_helper.dart';
import 'package:mi_fortitu/core/router/app_router.dart';
import 'package:mi_fortitu/features/access/presentation/blocs/access_bloc/access_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/di/dependency_injection.dart';
import 'features/clusters/presentation/blocs/clusters_bloc/clusters_bloc.dart';
import 'features/coalitions_blocs/presentation/blocs/coalitions_blocs_bloc/coalitions_blocs_bloc.dart';
import 'features/home/presentation/blocs/events_bloc/events_bloc.dart';
import 'features/profiles/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'features/slots/presentation/blocs/slots_bloc/slots_bloc.dart';

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
        BlocProvider(create: (_) => AccessBloc(sl(), sl(), sl(), sl(),),),
        BlocProvider(create: (_) => UserProfileBloc(sl())),
        BlocProvider(create: (_) => EventsBloc(sl(), sl(), sl())),
        BlocProvider(create: (_) => ClustersBloc(sl())),
        BlocProvider(create: (_) => CoalitionsBlocsBloc(sl())),
        BlocProvider(create: (_) => SlotsBloc(sl(), sl(), sl())),
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
