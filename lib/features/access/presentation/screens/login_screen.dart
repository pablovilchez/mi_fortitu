import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_fortitu/core/helpers/snackbar_helper.dart';
import 'package:mi_fortitu/features/access/presentation/blocs/access_bloc/access_bloc.dart';
import 'package:mi_fortitu/features/access/presentation/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AccessBloc>().add(LandingEvent());

    return BlocConsumer<AccessBloc, AccessState>(
      listener: (context, state) {
        if (state.message != null) {
          SnackbarHelper.showSnackbar(context, state.message!, isError: state.isError);
        } else if (state is Authenticated) {
          context.go('/home');
        } else if (state is WaitlistState) {
          context.go('/waitlist');
        }
      },
      builder: (context, state) {
        return Scaffold(
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
                  const SizedBox(height: 50),
                  const LoginForm(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
