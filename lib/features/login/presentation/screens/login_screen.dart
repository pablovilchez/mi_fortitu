import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:mi_fortitu/features/login/presentation/widgets/intra_button.dart';
import 'package:mi_fortitu/features/login/presentation/widgets/supa_form.dart';

import '../../../../core/utils/snackbar_helper.dart';
import '../bloc/supa_login_bloc/supa_login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SupaLoginBloc, SupaLoginState>(
      listener: (context, state) {
        if (state is SupaLoginSuccess) {
          context.go('/home');
        } else if (state is SupaLoginWaitlist) {
          context.go('/waitlist');
        } else if (state is SupaLoginFailure) {
          SnackbarHelper.showSnackbar(context, state.message, isError: true);
        }
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [SupaForm(), const SizedBox(height: 60), IntraButton()],
            ),
          ),
        ),
      ),
    );
  }
}
