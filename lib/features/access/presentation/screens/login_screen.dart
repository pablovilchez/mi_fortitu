import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_fortitu/core/helpers/snackbar_helper.dart';
import 'package:mi_fortitu/features/access/presentation/blocs/supa_login_bloc/auth_bloc.dart';
import 'package:mi_fortitu/features/access/presentation/widgets/login_text_fields.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(LandingEvent());
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          SnackbarHelper.showSnackbar(
            context,
            'Registered successfully. Check your email.',
          );
        } else if (state is LoginSuccess) {
          context.go('/home');
        } else if (state is WaitlistState) {
          context.go('/waitlist');
        } else if (state is LoginError) {
          SnackbarHelper.showSnackbar(context, state.message, isError: true);
        } else if (state is RegisterError) {
          SnackbarHelper.showSnackbar(context, state.message, isError: true);
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF9072F3), Color(0xFFE0E0E0)],
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 90),
                Image.asset('assets/images/logo_mi_fortitu.png', height: 200),
                const Text(
                  'v 0.1.0',
                  style: TextStyle(color: Colors.deepPurple),
                ),
                const SizedBox(height: 50),
                const LoginForm(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
