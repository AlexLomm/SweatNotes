import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:confetti/confetti.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upgrader/upgrader.dart';

part 'layout.g.dart';

class Layout extends ConsumerStatefulWidget {
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
  final EdgeInsets? padding;
  final bool? centerTitle;

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
    this.padding = const EdgeInsets.only(top: spacingTop),
    this.centerTitle = true,
  });

  @override
  ConsumerState createState() => _LayoutState();
}

class _LayoutState extends ConsumerState<Layout> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();

    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final leadingOrGoBackButton = widget.leading ??
        IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          tooltip: 'Navigate back',
          splashRadius: 20,
          onPressed: widget.onGoBackButtonTap,
        );

    return ProviderScope(
      overrides: [
        confettiControllerProvider.overrideWithValue(_confettiController),
      ],
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Scaffold(
              floatingActionButton: widget.floatingActionButton,
              appBar: widget.isAppBarVisible
                  ? AppBar(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      centerTitle: widget.centerTitle,
                      title: widget.appBarTitle ?? SvgPicture.asset(height: 48, 'assets/logo.svg'),
                      leading: leadingOrGoBackButton,
                      actions: widget.actions,
                    )
                  : null,
              endDrawer: widget.endDrawer,
              body: Theme(
                data: Theme.of(context).copyWith(
                  // style the auto-updater dialog
                  dialogTheme: DialogTheme(
                    titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                    contentTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
                child: UpgradeAlert(
                  child: SafeArea(
                    bottom: false,
                    child: Container(
                      padding: widget.padding,
                      child: widget.isScrollable ? SingleChildScrollView(child: widget.child) : widget.child,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 75,
            left: 125,
            child: _ConfettiWidgetConfigured(
              confettiController: _confettiController,
              blastDirection: pi * -0.25,
            ),
          ),
          Positioned(
            top: 75,
            right: 125,
            child: _ConfettiWidgetConfigured(
              confettiController: _confettiController,
              blastDirection: pi * -0.75,
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfettiWidgetConfigured extends StatelessWidget {
  final ConfettiController confettiController;
  final double blastDirection;

  const _ConfettiWidgetConfigured({
    required this.confettiController,
    required this.blastDirection,
  });

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: confettiController,
      blastDirection: blastDirection,
      minBlastForce: 5,
      maxBlastForce: 15,
      blastDirectionality: BlastDirectionality.explosive,
      particleDrag: 0.07,
      emissionFrequency: 0.001,
      numberOfParticles: 15,
      gravity: 0.05,
      shouldLoop: false,
      colors: const [
        Colors.green,
        Colors.blue,
        Colors.pink,
        Colors.orange,
        Colors.purple,
      ],
    );
  }
}

@Riverpod(dependencies: [])
ConfettiController confettiController(ConfettiControllerRef ref) {
  // going to be provided through ProviderScope override
  throw UnimplementedError();
}
