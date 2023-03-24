import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../../widgets/button.dart';
import '../../widgets/layout.dart';

class ResetPasswordFinishedScreen extends StatelessWidget {
  const ResetPasswordFinishedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      isAppBarVisible: false,
      isScrollable: false,
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
            // TODO: resize
            const Spacer(),
            Center(
              child: Container(
                width: 144.0,
                height: 144.0,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  color: Theme.of(context).colorScheme.surfaceVariant,
                ),
                child: Icon(
                  Icons.mark_email_unread_outlined,
                  size: 96.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            Center(
              child: Text(
                'Check your email',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            const SizedBox(height: 32.0),
            Text(
              "Please check your email for instructions on resetting your password. If you don't see the email, please check your spam folder!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 32.0),
            Button(
              label: 'Back to login',
              onPressed: () => context.goNamed('log-in'),
            ),
            const Spacer(),
            Text(
              "Didn't receive the email? check your spam folder or",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: () => context.goNamed(RouteNames.resetPassword),
              child: Text(
                'try a different email address',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
