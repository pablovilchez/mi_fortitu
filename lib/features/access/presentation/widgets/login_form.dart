import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/features/access/presentation/blocs/access_bloc/access_bloc.dart';
import 'package:mi_fortitu/features/access/presentation/widgets/validators.dart';

class AccessForm extends StatefulWidget {
  const AccessForm({super.key});

  @override
  State<AccessForm> createState() => _AccessFormState();
}

class _AccessFormState extends State<AccessForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccessBloc, AccessState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (state is RegisterFormState) ..._buildRegisterForm()
                else if (state is RequestRecoveryEmailFormState) ..._buildRecoveryPasswordForm()
                else ..._buildLoginForm(),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildLoginForm() {
    final bloc = context.read<AccessBloc>();
    return [
      _customTextField(_emailController, 'Email', Validators.validateEmail),
      _customTextField(_passwordController, 'Password', Validators.validatePassword, obscureText: true),
      const SizedBox(height: 40),
      _buildSubmitButton(isRegister: false),
      const SizedBox(height: 10),
      TextButton(
        onPressed: () {
          _resetControllersForState(bloc.state);
          bloc.add(ShowResetPasswordFormEvent());
        },
        child: const Text('Forgot password?'),
      ),
      TextButton(
        onPressed: () => bloc.add(ToggleFormEvent()),
        child: const Text("Don't have an account? Register"),
      ),
    ];
  }

  List<Widget> _buildRegisterForm() {
    final bloc = context.read<AccessBloc>();
    _confirmPassController.clear(); // prevent reuse
    return [
      _customTextField(_emailController, 'Email', Validators.validateEmail),
      _customTextField(_passwordController, 'Password', Validators.validatePassword, obscureText: true),
      _customTextField(
        _confirmPassController,
        'Confirm Password',
            (value) => Validators.validateConfirmPassword(_passwordController.text, value),
        obscureText: true,
      ),
      const SizedBox(height: 40),
      _buildSubmitButton(isRegister: true),
      const SizedBox(height: 10),
      TextButton(
        onPressed: () {
          bloc.add(ToggleFormEvent());
        },
        child: const Text("Already have an account? Login"),
      ),
    ];
  }

  List<Widget> _buildRecoveryPasswordForm() {
    final bloc = context.read<AccessBloc>();
    return [
      _customTextField(_emailController, 'Email', Validators.validateEmail),
      const SizedBox(height: 40),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            bloc.add(RequestDbRecoveryEmailEvent(email: _emailController.text));
          }
        },
        child: const Text("Send reset link"),
      ),
      const SizedBox(height: 10),
      TextButton(
        onPressed: () => bloc.add(ShowLoginFormEvent()),
        child: const Text("Back to login"),
      ),
    ];
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

  Widget _buildSubmitButton({required bool isRegister}) {
    return BlocBuilder<AccessBloc, AccessState>(
      builder: (context, state) {
        final isLoading = state is AccessLoading || state is AccessInitial;
        return ElevatedButton(
          onPressed: isLoading
              ? null
              : () {
            if (_formKey.currentState!.validate()) {
              final bloc = context.read<AccessBloc>();
              final email = _emailController.text;
              final password = _passwordController.text;

              if (isRegister) {
                bloc.add(RequestDbRegisterEvent(email: email, password: password));
              } else {
                bloc.add(RequestDbLoginEvent(email: email, password: password));
              }
            }
          },
          child: isLoading
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

  void _resetControllersForState(AccessState state) {
    _emailController.clear();
    _passwordController.clear();
    _confirmPassController.clear();

    if (state is RequestRecoveryEmailFormState) {
      _passwordController.text = '';
      _confirmPassController.text = '';
    }
  }
}
