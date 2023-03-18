import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:journal_flutter/features/auth/regular_text_field.dart';
import 'package:journal_flutter/widgets/button.dart';

import '../../widgets/layout.dart';
import 'password_field.dart';
import 'services/auth_service.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends ConsumerState<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

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

    final safeAreaHeight = mq.size.height - mq.padding.top - mq.padding.bottom - mq.viewInsets.bottom;

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
                onPressed: () => context.go('/auth/reset-password'),
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
              isLoading: _isLoading,
              onPressed: () async {
                setState(() => _isLoading = true);

                await authService.signIn(
                  email: _emailController.text,
                  password: _passwordController.text,
                );

                setState(() => _isLoading = false);
              },
            ),
            const SizedBox(height: 36),
            const _FadedDividerHorizontal(),
            const SizedBox(height: 36),
            Row(
              children: [
                _MaterialButtonWrapper(
                  // TODO: implement
                  // onTap: () => authService.signInWithApple(),
                  onTap: () {},
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SvgPicture.asset('assets/apple-logo.svg'),
                ),
                _MaterialButtonWrapper(
                  // TODO: implement
                  // onTap: () => authService.signInWithGoogle(),
                  onTap: () {},
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SvgPicture.asset('assets/google-logo.svg'),
                ),
                _MaterialButtonWrapper(
                  // TODO: implement
                  // onTap: () => authService.signInWithFacebook(),
                  onTap: () {},
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SvgPicture.asset('assets/facebook-logo.svg'),
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
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                ),
                TextButton(
                  onPressed: () => context.go('/auth/sign-up'),
                  child: Text('Sign up',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: Theme.of(context).colorScheme.primary)),
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
  final void Function() onTap;
  final Widget child;
  final EdgeInsets margin;

  const _MaterialButtonWrapper({
    Key? key,
    required this.onTap,
    required this.child,
    required this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: MaterialButton(
        onPressed: onTap,
        shape: const CircleBorder(),
        color: Theme.of(context).colorScheme.secondaryContainer,
        padding: const EdgeInsets.all(12.0),
        child: child,
      ),
    );
  }
}

class _FadedDividerHorizontal extends StatelessWidget {
  const _FadedDividerHorizontal({Key? key}) : super(key: key);

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
