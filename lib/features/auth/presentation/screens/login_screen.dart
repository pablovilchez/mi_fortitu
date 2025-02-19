import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_fortitu/features/auth/presentation/bloc/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController(text: 'pablovilchez.r@gmail.com');
  final TextEditingController _passwordController = TextEditingController(text: 'Abcd1234');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              FocusScope.of(context).unfocus();
              context.go('/home');
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
    
                ElevatedButton(
                  onPressed:
                      isLoading
                          ? null
                          : () {
                            context.read<AuthCubit>().login(
                              _emailController.text,
                              _passwordController.text,
                            );
                          },
                  child: Text('Login'),
                ),
                if (isLoading)
                  CircularProgressIndicator()
                else
                  TextButton(
                    onPressed: () {
                      context.push('/register');
                    },
                    child: Text('Don\'t have an account? Register'),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
