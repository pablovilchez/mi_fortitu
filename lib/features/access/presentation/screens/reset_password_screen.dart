import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helpers/snackbar_helper.dart';
import '../blocs/access_bloc/access_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final password = _passwordController.text.trim();
      final confirm = _confirmController.text.trim();

      if (password != confirm) {
        SnackbarHelper.showSnackbar(context, tr('access.message.pass_not_equal'), isError: true);
        return;
      }

      context.read<AccessBloc>().add(RequestSetNewPasswordEvent(newPassword: password));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccessBloc, AccessState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.go('/home');
        } else if (state.message != null) {
          SnackbarHelper.showSnackbar(context, state.message!, isError: state.isError);
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
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
              child: Column(
                children: [
                  Image.asset('assets/images/logo_mi_fortitu.png', height: 160),
                  const SizedBox(height: 40),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: tr('access.text_field.new_password'),
                          ),
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return tr('access.text_field.error_length');
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _confirmController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: tr('access.text_field.confirm_password'),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return tr('access.text_field.error_confirm_password');
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: state is AccessLoading ? null : _submit,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                          ),
                          child:
                              state is AccessLoading
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : Text(tr('access.text_field.reset_password')),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
