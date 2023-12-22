import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../../widgets/button.dart';
import '../../widgets/layout.dart';
import '../../shared/widgets/regular_text_field.dart';
import 'services/auth_service.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({
    super.key,
  });

  @override
  ConsumerState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  late final TextEditingController _emailController;

  bool _isValid = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController()
      ..addListener(() {
        setState(() => _isValid = _emailController.text.isNotEmpty);
      });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authServiceProvider);

    return Layout(
      onGoBackButtonTap: () => context.goNamed(RouteNames.logIn),
      appBarTitle: Text(
        'Reset Password',
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
            Text(
              'Please enter your email address below to reset your password. We will send you an email with instructions on how to reset your password.',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 24.0),
            RegularTextField(
              controller: _emailController,
              labelText: 'Email',
              hintText: 'Enter valid email address',
            ),
            const SizedBox(height: 24.0),
            Button(
              label: 'Send',
              isLoading: _isLoading,
              onPressed: _isValid
                  ? () async {
                      setState(() => _isLoading = true);

                      await authService
                          .sendPasswordResetEmail(_emailController.text);

                      if (mounted) setState(() => _isLoading = false);
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
