import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/core/utils/snackbar_helper.dart';
import 'package:mi_fortitu/features/login/presentation/bloc/intra_login_cubit/intra_login_cubit.dart';
import 'package:mi_fortitu/features/login/presentation/bloc/supa_login_bloc/supa_login_bloc.dart';
import 'package:mi_fortitu/features/login/presentation/widgets/validators.dart';

class SupaForm extends StatefulWidget {
  const SupaForm({super.key});

  @override
  State<SupaForm> createState() => _SupaForm();
}

class _SupaForm extends State<SupaForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _loginNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final supaLoginBloc = context.read<SupaLoginBloc>();
    final isIntraAuthenticated =
    context
        .watch<IntraLoginCubit>()
        .state is IntraLoginSuccess;

    return BlocBuilder<SupaLoginBloc, SupaLoginState>(
      builder: (context, state) {
        final isRegister = state is SupaLoginRegister;

        _passController.clear();
        _confirmPassController.clear();
        _loginNameController.clear();

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
                  _passController,
                  'Password',
                  Validators.validatePassword,
                  obscureText: true,
                ),
                if (isRegister) ...[
                  _customTextField(
                    _confirmPassController,
                    'Confirm Password',
                        (value) =>
                        Validators.validateConfirmPassword(
                          _passController.text,
                          value,
                        ),
                    obscureText: true,
                  ),
                  _customTextField(
                    _loginNameController,
                    'Your Intra Login',
                    Validators.validateLoginName,
                  ),
                ],

                SizedBox(height: 40),

                _buildSubmitButton(
                  isIntraAuthenticated,
                  isRegister,
                  supaLoginBloc,
                ),

                SizedBox(height: 10),

                _buildToggleButton(isRegister, supaLoginBloc),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _customTextField(TextEditingController controller,
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

  Widget _buildSubmitButton(bool isIntraAuthenticated,
      bool isRegister,
      SupaLoginBloc bloc,) {
    return BlocBuilder<SupaLoginBloc, SupaLoginState>(
      builder: (context, state) {
        final isLoading = state is SupaLoginLoading;

        return ElevatedButton(
          onPressed: () {
            if (!isIntraAuthenticated) {
              SnackbarHelper.showSnackbar(
                context,
                'You need to allow INTRA first',
                isError: true,
              );
            } else if (_formKey.currentState!.validate()) {
              if (isRegister) {
                bloc.add(
                  SupaRegisterEvent(
                    email: _emailController.text,
                    password: _passController.text,
                    loginName: _loginNameController.text,
                  ),
                );
              } else {
                bloc.add(
                  SupaAuthEvent(
                    email: _emailController.text,
                    password: _passController.text,
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

  Widget _buildToggleButton(bool isRegister, SupaLoginBloc bloc) {
    return TextButton(
      onPressed: () {
        _formKey.currentState!.reset();
        bloc.add(SupaToggleFormEvent());
      },
      child: Text(
        isRegister
            ? 'Already have an account? Login'
            : 'Don\'t have an account? Register',
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    _loginNameController.dispose();
    super.dispose();
  }
}
