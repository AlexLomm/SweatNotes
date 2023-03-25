import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../../widgets/button.dart';
import '../../widgets/display_name_field.dart';
import '../../widgets/layout.dart';
import 'password_field.dart';
import 'regular_text_field.dart';
import 'services/auth_service.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _displayNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authServiceProvider);

    return Layout(
      onGoBackButtonTap: () => context.goNamed(RouteNames.logIn),
      appBarTitle: Text(
        'Sign Up',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24.0),
            DisplayNameField(controller: _displayNameController),
            const SizedBox(height: 24.0),
            RegularTextField(
              controller: _emailController,
              labelText: 'Email',
              hintText: 'Enter valid email address',
            ),
            const SizedBox(height: 24.0),
            PasswordField(
              controller: _passwordController,
              labelText: 'Password',
              hintText: 'Enter secure password',
              helperText: '8 characters or longer',
            ),
            const SizedBox(height: 44.0),
            Button(
              label: 'Sign up',
              isLoading: _isLoading,
              onPressed: () async {
                setState(() => _isLoading = true);

                await authService.signUp(
                  displayName: _displayNameController.text,
                  email: _emailController.text,
                  password: _passwordController.text,
                );

                setState(() => _isLoading = false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
