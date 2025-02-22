import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_fortitu/features/auth/presentation/bloc/auth_bloc.dart';

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
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthPendingApproval) {
                context.go('/waitlist');
              } else if (state is AuthError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              final bool isLoading = state is AuthLoading;
              final bool isIntraLoggedIn =
                  context.read<AuthBloc>().isIntraLoggedIn;
    
              return Column(
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email / Account'),
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

                  SizedBox(height: 16),
                  
                  isIntraLoggedIn
                    ? ElevatedButton(
                      onPressed: null, // TODO: Implement revoke 42 API
                      child: Text(
                        'Revoke 42 API',
                        style: TextStyle(color: Colors.lightGreen),
                      ),
                    )
                    : ElevatedButton(
                      onPressed: null, // TODO: Implement authorize 42 API
                      child: Text(
                        'Authorize 42 API',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),

                SizedBox(height: 16),

                  ElevatedButton(
                    onPressed:
                        isLoading ? null : () {
                              if (_passwordController.text ==
                                  _confirmPasswordController.text) {
                                context.read<AuthBloc>().add(
                                  AuthRegister(
                                  _emailController.text,
                                  _passwordController.text,
                                  'name'
                                ));
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
