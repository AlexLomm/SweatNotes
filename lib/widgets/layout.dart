import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/services/auth_service.dart';
import '../theme_switcher.dart';

class Layout extends ConsumerWidget {
  static const spacingTop = 16.0;

  final Widget child;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final bool isScrollable;
  final bool isGoBackButtonVisible;

  const Layout({
    super.key,
    required this.child,
    this.floatingActionButton,
    this.actions,
    this.isScrollable = true,
    this.isGoBackButtonVisible = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: move to drawer
    final authService = ref.watch(authServiceProvider);
    final themeSwitcher = ref.watch(themeSwitcherProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: SvgPicture.asset(
          height: 48,
          'assets/logo.svg',
        ),
        leading: isGoBackButtonVisible
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                tooltip: 'Navigate to home screen',
                splashRadius: 20,
                onPressed: () => context.go('/'),
              )
            : null,
        actions: actions,
        // actions: [
        //   // IconButton(
        //   //   icon: Icon(
        //   //     Icons.wb_sunny_outlined,
        //   //     color: Theme.of(context).colorScheme.onSurface,
        //   //   ),
        //   //   tooltip: 'Switch theme',
        //   //   splashRadius: 20,
        //   //   onPressed: () => themeSwitcher.toggle(),
        //   // ),
        //   IconButton(
        //     icon: Icon(
        //       Icons.logout_outlined,
        //       color: Theme.of(context).colorScheme.onSurface,
        //     ),
        //     tooltip: 'Sign out',
        //     splashRadius: 20,
        //     onPressed: () => authService.signOut(),
        //   ),
        //   // IconButton(
        //   //   icon: Icon(Icons.add, color: Theme.of(context).colorScheme.onSurface),
        //   //   tooltip: 'Add new entry',
        //   //   splashRadius: 20,
        //   //   onPressed: () {},
        //   // ),
        //   // IconButton(
        //   //   icon: Icon(
        //   //     Icons.settings_outlined,
        //   //     color: Theme.of(context).colorScheme.onSurface,
        //   //   ),
        //   //   tooltip: 'View entries',
        //   //   splashRadius: 20,
        //   //   onPressed: () {},
        //   // ),
        // ],
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.only(top: spacingTop),
          // TODO: replace with ListView.builder https://www.youtube.com/watch?v=YY-_yrZdjGc&t=6s
          child: isScrollable ? SingleChildScrollView(child: child) : child,
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
