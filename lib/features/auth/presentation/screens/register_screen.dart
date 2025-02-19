import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_fortitu/features/auth/presentation/bloc/auth_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController(text: 'pablovilchez.r@gmail.com');
  final TextEditingController _passwordController = TextEditingController(text: 'Abcd1234');
  final TextEditingController _confirmPasswordController = TextEditingController(text: 'Abcd1234');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                context.go('/login');
              } else if (state is AuthError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              final bool isLoading = state is AuthLoading;
    
              return Column(
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  TextField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                    ),
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed:
                        isLoading
                            ? null
                            : () {
                              if (_passwordController.text ==
                                  _confirmPasswordController.text) {
                                context.read<AuthCubit>().register(
                                  _emailController.text,
                                  _passwordController.text,
                                  'name'
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Passwords do not match'),
                                  ),
                                );
                              }
                            },
                    child: Text('Register'),
                  ),
                  if (isLoading)
                    CircularProgressIndicator()
                  else
                    TextButton(
                      onPressed: () {
                        context.push('/login');
                      },
                      child: Text('I already have an account. Sign in'),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
