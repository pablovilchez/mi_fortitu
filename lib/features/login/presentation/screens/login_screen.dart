import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mi_fortitu/features/login/presentation/bloc/intra_login_cubit/intra_login_cubit.dart';
import 'package:mi_fortitu/features/login/presentation/bloc/supa_login_bloc/supa_login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SupaForm(), const SizedBox(height: 60), IntraButton()],
          ),
        ),
      ),
    );
  }
}

class SupaForm extends StatefulWidget {
  const SupaForm({super.key});

  @override
  State<SupaForm> createState() => _SupaBlocConsumerState();
}

class _SupaBlocConsumerState extends State<SupaForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _loginNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SupaLoginBloc, SupaLoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        final isRegister = state is SupaLoginRegister;
        final isLoading = state is SupaLoginLoading;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              TextField(
                controller: _passController,
                decoration: const InputDecoration(hintText: 'Password'),
              ),
              if (isRegister) ...[
                TextField(
                  controller: _confirmPassController,
                  decoration: const InputDecoration(
                    hintText: 'Confirm Password',
                  ),
                ),
                TextField(
                  controller: _loginNameController,
                  decoration: const InputDecoration(
                    hintText: 'Your Intra Login',
                  ),

                ),
              ],
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  final supaLoginBloc = context.read<SupaLoginBloc>();
                  if (isRegister) {
                    supaLoginBloc.add(
                      SupaRegisterEvent(
                        email: _emailController.text,
                        password: _passController.text,
                        confirmPassword: _confirmPassController.text,
                      ),
                    );
                  } else {
                    supaLoginBloc.add(
                      SupaAuthEvent(
                        email: _emailController.text,
                        password: _passController.text,
                      ),
                    );
                  }
                },
                child:
                    isLoading
                        ? SizedBox(
                          width: 20,
                          height: 20,
                          child: const CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        )
                        : Text(isRegister ? 'Register' : 'Login'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  context.read<SupaLoginBloc>().add(SupaToggleFormEvent());
                },
                child: Text(
                  isRegister
                      ? 'Already have an account? Login'
                      : 'Don\'t have an account? Register',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }
}

class IntraButton extends StatelessWidget {
  const IntraButton({super.key});

  @override
  Widget build(BuildContext context) {
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
            if (isAuthenticated) {
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
