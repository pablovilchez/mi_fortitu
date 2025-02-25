import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mi_fortitu/features/login/presentation/bloc/intra_login_cubit/intra_login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('LOGIN SCREEN'),
            const SizedBox(height: 20),
            BlocBuilder<IntraLoginCubit, IntraLoginState>(
              builder: (context, state) {
                final isAuthenticated = state is IntraLoginSuccess;
                final isLoading = state is IntraLoginLoading;

                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isAuthenticated
                            ? Colors.green.shade200
                            : Colors.red.shade200,
                  ),
                  onPressed: () async {
                    final cubit = context.read<IntraLoginCubit>();
                    if (isAuthenticated) {
                      cubit.logout();
                    } else {
                      await cubit.login();
                    }
                  },
                  child: () {
                    if (isAuthenticated) {
                      return const Text('LOGOUT');
                    } else if (isLoading) {
                      return const CircularProgressIndicator();
                    } else {
                      return const Text('LOGIN');
                    }
                  }(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
