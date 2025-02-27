import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/features/login/presentation/bloc/intra_login_cubit/intra_login_cubit.dart';


class IntraButton extends StatelessWidget {
  const IntraButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isAuthLoading = context.watch<IntraLoginCubit>().state is IntraLoginLoading;

    return BlocConsumer<IntraLoginCubit, IntraLoginState>(
      listener: (context, state) {
        if (state is IntraLoginFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isAuthenticated = state is IntraLoginSuccess;
        final isLoading = state is IntraLoginLoading;

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
            isAuthenticated ? Colors.green.shade200 : Colors.red.shade200,
          ),
          onPressed: () async {
            final cubit = context.read<IntraLoginCubit>();
            if (isAuthenticated && !isAuthLoading) {
              cubit.logout();
            } else {
              await cubit.login();
            }
          },
          child: () {
            if (isAuthenticated) {
              return const Text('Log Out INTRA');
            } else if (isLoading) {
              return SizedBox(
                width: 20,
                height: 20,
                child: const CircularProgressIndicator(strokeWidth: 3),
              );
            } else {
              return const Text('Log In INTRA');
            }
          }(),
        );
      },
    );
  }
}
