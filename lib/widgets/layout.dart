import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class Layout extends ConsumerWidget {
  static const spacingTop = 16.0;

  final Widget child;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final bool isScrollable;
  final Widget? leading;
  final Drawer? endDrawer;
  final bool isAppBarVisible;
  final Function()? onGoBackButtonTap;
  final Widget? appBarTitle;

  const Layout({
    super.key,
    required this.child,
    this.floatingActionButton,
    this.actions,
    this.isScrollable = true,
    this.leading,
    this.endDrawer,
    this.isAppBarVisible = true,
    this.onGoBackButtonTap,
    this.appBarTitle,
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
          onPressed: onGoBackButtonTap,
        );

    return Scaffold(
      appBar: isAppBarVisible
          ? AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              centerTitle: true,
              title: appBarTitle ?? SvgPicture.asset(height: 48, 'assets/logo.svg'),
              leading: leadingOrGoBackButton,
              actions: actions,
            )
          : null,
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
