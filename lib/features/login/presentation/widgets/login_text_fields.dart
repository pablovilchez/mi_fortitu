import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/features/login/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:mi_fortitu/features/login/presentation/widgets/validators.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _SupaForm();
}

class _SupaForm extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final isRegister = state is RegisterFormState;

        _confirmPassController.clear();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _customTextField(
                  _emailController,
                  'Email',
                  Validators.validateEmail,
                ),
                _customTextField(
                  _passwordController,
                  'Password',
                  Validators.validatePassword,
                  obscureText: true,
                ),
                if (isRegister) ...[
                  _customTextField(
                    _confirmPassController,
                    'Confirm Password',
                    (value) => Validators.validateConfirmPassword(
                      _passwordController.text,
                      value,
                    ),
                    obscureText: true,
                  ),
                ],
                SizedBox(height: 40),
                _buildSubmitButton(),
                SizedBox(height: 10),
                _buildToggleButton(loginBloc),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _customTextField(
    TextEditingController controller,
    String hint,
    String? Function(String?)? validator, {
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(hintText: hint),
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final isLoading = state is LoadingState || state is LandingState;
        final isRegister = state is RegisterFormState;

        return ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (isRegister) {
                context.read<LoginBloc>().add(
                  RequestRegisterEvent(
                    email: _emailController.text,
                    password: _passwordController.text,
                  ),
                );
              } else {
                context.read<LoginBloc>().add(
                  RequestLoginEvent(
                    email: _emailController.text,
                    password: _passwordController.text,
                  ),
                );
              }
            }
          },
          child:
              isLoading
                  ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 3),
                  )
                  : Text(isRegister ? 'Register' : 'Login'),
        );
      },
    );
  }

  Widget _buildToggleButton(LoginBloc bloc) {
    final state = bloc.state;
    return TextButton(
      onPressed: state is LandingState || state is LoadingState
          ? null
          : () => bloc.add(ToggleFormEvent()),
      child: Text(
        state is RegisterFormState
            ? 'Already have an account? Login'
            : 'Don\'t have an account? Register',
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }
}
