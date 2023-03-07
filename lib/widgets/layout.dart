import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class Layout extends ConsumerWidget {
  static const spacingTop = 16.0;

  final Widget child;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final bool isScrollable;
  final Widget? leading;
  final Drawer? endDrawer;

  const Layout({
    super.key,
    required this.child,
    this.floatingActionButton,
    this.actions,
    this.isScrollable = true,
    this.leading,
    this.endDrawer,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leadingOrGoBackButton = leading ??
        IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          tooltip: 'Navigate to home screen',
          splashRadius: 20,
          onPressed: () => context.go('/'),
        );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: SvgPicture.asset(
          height: 48,
          'assets/logo.svg',
        ),
        leading: leadingOrGoBackButton,
        actions: actions,
      ),
      endDrawer: endDrawer,
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
