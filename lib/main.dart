import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mi_fortitu/core/themes/main_theme.dart';
import 'package:mi_fortitu/features/login/presentation/bloc/intra_login_cubit/intra_login_cubit.dart';
import 'package:mi_fortitu/features/login/presentation/bloc/supa_login_bloc/supa_login_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:mi_fortitu/core/router/app_router.dart';

import 'core/themes/philosopher/theme.dart';
import 'core/themes/philosopher/util.dart';


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
    // final brigthness = MediaQuery.of(context).platformBrightness;
    // TextTheme textTheme = createTextTheme(context, "Philosopher", "Philosopher");
    // MaterialTheme theme = MaterialTheme(textTheme);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SupaLoginBloc()),
        BlocProvider(create: (_) => IntraLoginCubit()),
      ],
      child: MaterialApp.router(
        // theme: brigthness == Brightness.light ? theme.light() : theme.dark(),
        // theme: MainTheme.theme,
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
