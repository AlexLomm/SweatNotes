import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../services/auth_service.dart';

class Layout extends ConsumerWidget {
  final Widget child;
  final Widget? floatingActionButton;
  final bool isScrollable;

  const Layout({
    super.key,
    required this.child,
    this.floatingActionButton,
    this.isScrollable = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authServiceProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: SvgPicture.asset(
          height: 48,
          'assets/logo.svg',
        ),
        leading: Image.asset(
          height: 36,
          'assets/profile-image-placeholder.png',
        ),
        actions: [
          IconButton(
            // TODO: extract color
            icon: const Icon(
              Icons.wb_sunny_outlined,
              color: Color.fromRGBO(28, 27, 31, 1),
            ),
            tooltip: 'Switch theme',
            splashRadius: 20,
            onPressed: () => context.go('/'),
          ),
          IconButton(
            // TODO: extract color
            icon: const Icon(Icons.home, color: Color.fromRGBO(28, 27, 31, 1)),
            tooltip: 'Go home',
            splashRadius: 20,
            onPressed: () => context.go('/'),
          ),
          IconButton(
            // TODO: extract color
            icon: const Icon(
              Icons.logout_outlined,
              color: Color.fromRGBO(28, 27, 31, 1),
            ),
            tooltip: 'Sign out',
            splashRadius: 20,
            onPressed: () => authService.signOut(),
          ),
          // IconButton(
          //   // TODO: extract color
          //   icon: const Icon(Icons.add, color: Color.fromRGBO(28, 27, 31, 1)),
          //   tooltip: 'Add new entry',
          //   splashRadius: 20,
          //   onPressed: () {},
          // ),
          // IconButton(
          //   icon: const Icon(
          //     Icons.settings_outlined,
          //     color: Color.fromRGBO(28, 27, 31, 1),
          //   ),
          //   tooltip: 'View entries',
          //   splashRadius: 20,
          //   onPressed: () {},
          // ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.only(top: 16.0),
          child: isScrollable ? SingleChildScrollView(child: child) : child,
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
