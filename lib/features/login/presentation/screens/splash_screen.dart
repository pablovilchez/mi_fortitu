import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_fortitu/features/login/presentation/bloc/supa_login_bloc/supa_login_bloc.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    print('Paso 1: SplashScreen initState');
    context.read<SupaLoginBloc>().add(SupaInitCheckEvent());
  }

  @override
  Widget build(BuildContext context) {
    final supaLoginBloc = context.read<SupaLoginBloc>();

    print('Paso 3: SplashScreen build');

    return BlocListener<SupaLoginBloc, SupaLoginState>(
      listener: (context, state) {
        if (state is SupaLoginInitial) {
          print('Estado: SupaLoginInitial, va a /login');
          context.go('/login');
        } else if (state is SupaLoginSuccess) {
          print('Estado: SupaLoginSuccess, va a checkRol');
          supaLoginBloc.add(SupaCheckRolEvent());
        } else if (state is SupaLoginWaitlist) {
          print('Estado: SupaLoginWaitlist, va a /waitlist');
          context.go('/waitlist');
        } else if (state is SupaLoginHome) {
          print('Estado: SupaLoginHome, va a /home');
          context.go('/home');
        }
      },
      child: const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading...'),
            ],
          ),
        ),
      ),
    );
  }
}
