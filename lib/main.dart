import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mi_fortitu/features/home/presentation/bloc/intra_events_bloc/intra_events_bloc.dart';
import 'package:mi_fortitu/features/home/presentation/bloc/intra_profile_bloc/intra_profile_bloc.dart';
import 'package:mi_fortitu/features/login/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:mi_fortitu/core/router/app_router.dart';

import 'features/home/presentation/bloc/intra_search_profile_bloc/intra_search_profile_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  await Supabase.initialize(
    url: dotenv.env['SUPA_URL']!,
    anonKey: dotenv.env['SUPA_ANON_KEY']!,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => IntraProfileBloc()),
        BlocProvider(create: (_) => IntraSearchProfileBloc()),
        BlocProvider(create: (_) => IntraEventsBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
