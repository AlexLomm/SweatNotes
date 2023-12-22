import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../../widgets/button.dart';
import '../../widgets/layout.dart';
import '../../shared/widgets/password_field.dart';
import '../../shared/widgets/regular_text_field.dart';
import 'services/auth_service.dart';

class LogInScreen extends ConsumerStatefulWidget {
  const LogInScreen({super.key});

  @override
  LogInScreenState createState() => LogInScreenState();
}

class LogInScreenState extends ConsumerState<LogInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _signInWithEmailAndPasswordLoading = false;
  bool _signInWithAppleLoading = false;
  bool _signInWithGoogleLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final authService = ref.watch(authServiceProvider);

    final safeAreaHeight = mq.size.height -
        mq.padding.top -
        mq.padding.bottom -
        mq.viewInsets.bottom;

    return Layout(
      isAppBarVisible: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: safeAreaHeight * 0.09,
                bottom: safeAreaHeight * 0.12,
              ),
              child: SvgPicture.asset(height: 80, 'assets/logo.svg'),
            ),
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
            ),
            const SizedBox(height: 24.0),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => context.goNamed(RouteNames.resetPassword),
                child: Text(
                  'Forgot password?',
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            Button(
              label: 'Log in',
              isLoading: _signInWithEmailAndPasswordLoading,
              onPressed: () async {
                setState(() => _signInWithEmailAndPasswordLoading = true);

                await authService.signIn(
                  email: _emailController.text,
                  password: _passwordController.text,
                );

                setState(() => _signInWithEmailAndPasswordLoading = false);
              },
            ),
            const SizedBox(height: 36),
            const _FadedDividerHorizontal(),
            const SizedBox(height: 36),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _MaterialButtonWrapper(
                  isLoading: _signInWithAppleLoading,
                  onTap: _signInWithAppleLoading
                      ? null
                      : () async {
                          setState(() => _signInWithAppleLoading = true);

                          await authService.signInWithApple();

                          setState(() => _signInWithAppleLoading = false);
                        },
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SvgPicture.asset('assets/apple-logo.svg'),
                ),
                _MaterialButtonWrapper(
                  isLoading: _signInWithGoogleLoading,
                  onTap: _signInWithGoogleLoading
                      ? null
                      : () async {
                          setState(() => _signInWithGoogleLoading = true);

                          await authService.signInWithGoogle();

                          setState(() => _signInWithGoogleLoading = false);
                        },
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SvgPicture.asset('assets/google-logo.svg'),
                ),
              ],
            ),
            const SizedBox(height: 36.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: Text('Not a member?',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant)),
                ),
                TextButton(
                  onPressed: () => context.goNamed(RouteNames.signUp),
                  child: Text('Sign up',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary)),
                ),
              ],
            ),
            const SizedBox(height: 36.0),
          ],
        ),
      ),
    );
  }
}

class _MaterialButtonWrapper extends StatelessWidget {
  final bool isLoading;
  final void Function()? onTap;
  final Widget child;
  final EdgeInsets margin;

  const _MaterialButtonWrapper({
    this.isLoading = false,
    this.onTap,
    required this.child,
    required this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: MaterialButton(
        onPressed: onTap,
        shape: const CircleBorder(),
        color: Theme.of(context).colorScheme.secondaryContainer,
        padding: const EdgeInsets.all(12.0),
        child: isLoading
            ? CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onSecondaryContainer)
            : child,
      ),
    );
  }
}

class _FadedDividerHorizontal extends StatelessWidget {
  const _FadedDividerHorizontal();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: 1.0,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Color.fromRGBO(73, 69, 79, 1),
                  Color.fromRGBO(73, 69, 79, 0),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        Text(
          'Or continue with',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Container(
            height: 1.0,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromRGBO(73, 69, 79, 1),
                  Color.fromRGBO(73, 69, 79, 0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
