import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweatnotes/widgets/button.dart';

import '../../features/settings/timer_settings.dart';
import '../../features/training_block/widget_params.dart';
import 'timer_custom_input.dart';
import 'timer_display.dart';
import 'timer_floating_button.dart';
import 'timer_placeholder_button.dart';
import 'timer_play_pause_button.dart';
import 'timer_stop_button.dart';
import 'timer_time_modifier_button.dart';

class ExpandableTimer extends ConsumerStatefulWidget {
  static const animationDuration = Duration(milliseconds: 600);
  static const animationCurve = Cubic(0.9, 0.03, 0.69, 0.22);

  const ExpandableTimer({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _ExpandableTimerState();
}

class _ExpandableTimerState extends ConsumerState<ExpandableTimer> with TickerProviderStateMixin {
  bool isCustomInputMode = false;

  late GlobalKey _key;
  late Offset _buttonPosition;
  late Size _buttonSize;
  OverlayEntry? _menuOverlayEntry;
  OverlayEntry? _backdropOverlayEntry;

  late AnimationController _animationController;
  late Animation<double> _contentOpacityAnimation;
  late Animation<double> _containerExpandAnimation;
  late Animation<double> _timerProgressBorderOpacityAnimation;

  late AnimationController _timerController;
  late Animation<int> _timerCountdownAnimation;
  late Animation<double> _timerProgressAnimation;

  get isCompletedOrAnimatingForward =>
      _animationController.status == AnimationStatus.completed ||
      _animationController.status == AnimationStatus.forward;

  get isDismissedOrAnimatingReverse =>
      _animationController.status == AnimationStatus.dismissed ||
      _animationController.status == AnimationStatus.reverse;

  get isDismissed => _animationController.status == AnimationStatus.dismissed;

  get isTimerPlaying => _timerController.isAnimating;

  get isTimerReset => _timerController.status == AnimationStatus.dismissed;

  get isTimerFinished => _timerController.status == AnimationStatus.completed || _timerCountdownAnimation.value <= 0;

  get areIncrementButtonsEnabled => !isCustomInputMode && isTimerReset;

  @override
  void initState() {
    super.initState();

    final timerSettings = ref.read(timerSettingsProvider);

    _animationController = AnimationController(
      vsync: this,
      duration: ExpandableTimer.animationDuration,
    )..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) _removeOverlays();
      });

    _timerProgressBorderOpacityAnimation = Tween<double>(begin: 1.0, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0,
          0.33,
          curve: ExpandableTimer.animationCurve,
        ),
      ),
    );

    _contentOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.33,
          1.0,
          curve: ExpandableTimer.animationCurve,
        ),
      ),
    );

    _containerExpandAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.33,
          1.0,
          curve: ExpandableTimer.animationCurve,
        ),
      ),
    );

    _timerController = AnimationController(
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) _resetTimer();
      });

    _timerCountdownAnimation = IntTween(begin: timerSettings.initialSeconds, end: 0).animate(
      CurvedAnimation(
        parent: _timerController,
        curve: Curves.linear,
      ),
    );

    _timerProgressAnimation = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(
        parent: _timerController,
        curve: Curves.linear,
      ),
    );

    _key = GlobalKey();
  }

  void _removeOverlays() {
    _menuOverlayEntry?.remove();
    _menuOverlayEntry = null;

    _backdropOverlayEntry?.remove();
    _backdropOverlayEntry = null;
  }

  @override
  void dispose() {
    _removeOverlays();
    _animationController.dispose();

    super.dispose();
  }

  void _closeMenu({bool giveHapticFeedback = false}) {
    if (isDismissedOrAnimatingReverse) return;

    if (giveHapticFeedback) {
      HapticFeedback.mediumImpact();
    }

    _animationController.reverse();
  }

  void _openMenu() {
    if (isCompletedOrAnimatingForward) return;

    final renderBox = _key.currentContext?.findRenderObject() as RenderBox;

    _buttonSize = renderBox.size;
    _buttonPosition = renderBox.localToGlobal(Offset.zero);

    if (_menuOverlayEntry == null && _backdropOverlayEntry == null) {
      final backdropOverlayEntry = _backdropOverlayEntryBuilder();
      final menuOverlayEntry = _menuOverlayEntryBuilder();

      _backdropOverlayEntry = backdropOverlayEntry;
      _menuOverlayEntry = menuOverlayEntry;

      Overlay.of(context).insert(backdropOverlayEntry);
      Overlay.of(context).insert(menuOverlayEntry);
    }

    HapticFeedback.mediumImpact();

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => !_animationController.isAnimating && isDismissed
          ? AnimatedBuilder(
              animation: _timerController,
              builder: (context, child) => TimerFloatingButton(
                key: _key,
                seconds: _timerController.isAnimating ? _timerCountdownAnimation.value : null,
                progress: _timerProgressAnimation.value,
                progressOpacity: _timerProgressBorderOpacityAnimation.value,
                onTap: () {
                  // only handle opening the menu, closing is handled separately.
                  // Also, `isDismissed` check is needed to cover an edge case when
                  // the button is clicked through the backdrop
                  if (isDismissed) _openMenu();
                },
              ),
            )
          : Container(),
    );
  }

  OverlayEntry _backdropOverlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned.fill(
          child: Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (event) => _closeMenu(),
          ),
        );
      },
    );
  }

  OverlayEntry _menuOverlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        final timerSettings = ref.watch(timerSettingsProvider);

        final mq = MediaQuery.of(context);

        const containerHeightBase = 224.0;
        final containerWidthBase = min(400.0, mq.size.width - 2 * 16.0);

        return Positioned(
          top: _buttonPosition.dy + _buttonSize.height - containerHeightBase,
          left: _buttonPosition.dx + _buttonSize.width - containerWidthBase,
          child: SizedBox(
            height: containerHeightBase,
            width: containerWidthBase,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Material(
                        elevation: 3.0,
                        color: Theme.of(context).colorScheme.surface,
                        surfaceTintColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: SizedBox(
                          height: TimerFloatingButton.height +
                              ((containerHeightBase - TimerFloatingButton.height) * _containerExpandAnimation.value),
                          width: TimerFloatingButton.width +
                              ((containerWidthBase - TimerFloatingButton.width) * _containerExpandAnimation.value),
                          child: child,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Opacity(
                        opacity: _contentOpacityAnimation.value.clamp(0, 1.0),
                        child: Container(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TimerTimeModifierButton(
                                text: '-15',
                                onTap: areIncrementButtonsEnabled ? _decrementTimer : null,
                              ),
                              AnimatedBuilder(
                                animation: _timerController,
                                builder: (context, child) => AnimatedCrossFade(
                                  duration: WidgetParams.animationDuration,
                                  firstCurve: WidgetParams.animationCurve,
                                  secondCurve: WidgetParams.animationCurve,
                                  crossFadeState:
                                      isCustomInputMode ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                  firstChild: TimerCustomInput(
                                    isActive: isCustomInputMode,
                                    initialValue: _timerCountdownAnimation.value,
                                    onChange: _setInitialSecondsTo,
                                  ),
                                  secondChild: TimerDisplay(
                                    seconds: _timerCountdownAnimation.value,
                                    onTap: _switchToCustomInputMode,
                                  ),
                                ),
                              ),
                              TimerTimeModifierButton(
                                text: '+15',
                                onTap: areIncrementButtonsEnabled ? _incrementTimer : null,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Opacity(
                        opacity: _contentOpacityAnimation.value.clamp(0, 1.0),
                        child: AnimatedCrossFade(
                          duration: WidgetParams.animationDuration,
                          firstCurve: WidgetParams.animationCurve,
                          secondCurve: WidgetParams.animationCurve,
                          crossFadeState: isCustomInputMode ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                          firstChild: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8.0,
                              left: 24.0,
                              right: 24.0,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Button(
                                  onPressed: _switchToNormalInputMode,
                                  child: Text(
                                    'Done',
                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                          color: Theme.of(context).colorScheme.onPrimary,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          secondChild: Padding(
                            padding: const EdgeInsets.only(bottom: 24.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const TimerPlaceholderButton(),
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: TimerPlayPauseButton(
                                    isPlaying: isTimerPlaying,
                                    isDisabled: isTimerFinished,
                                    onTapPlay: _startTimer,
                                    onTapPause: _pauseTimer,
                                  ),
                                ),
                                TimerStopButton(
                                  onTap: isTimerReset ? null : _resetTimer,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Opacity(
                        opacity: 1.0 - _containerExpandAnimation.value.clamp(0, 1.0),
                        child: TimerFloatingButton(
                          isPlaceholder: true,
                          seconds: isTimerPlaying ? _timerCountdownAnimation.value : null,
                          progress: _timerProgressAnimation.value,
                          progressOpacity: _timerProgressBorderOpacityAnimation.value,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Opacity(
                        opacity: _contentOpacityAnimation.value.clamp(0, 1.0),
                        child: IconButton(
                          icon: Icon(Icons.close, color: Theme.of(context).colorScheme.onSurface),
                          onPressed: () => _closeMenu(giveHapticFeedback: true),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _switchToNormalInputMode() {
    setState(() => isCustomInputMode = false);

    _menuOverlayEntry?.markNeedsBuild();
  }

  void _switchToCustomInputMode() {
    if (isTimerPlaying) return;

    setState(() => isCustomInputMode = true);

    _menuOverlayEntry?.markNeedsBuild();
  }

  void _pauseTimer() {
    _timerController.stop();

    _menuOverlayEntry?.markNeedsBuild();
  }

  void _startTimer() {
    if (isTimerReset) {
      final timerSettings = ref.read(timerSettingsProvider);

      _timerCountdownAnimation = IntTween(begin: timerSettings.initialSeconds, end: 0).animate(
        CurvedAnimation(parent: _timerController, curve: Curves.linear),
      );

      _timerController.duration = Duration(seconds: timerSettings.initialSeconds);
    }

    _timerController.forward();

    _menuOverlayEntry?.markNeedsBuild();
  }

  void _incrementTimer() {
    final timerSettingsNotifier = ref.read(timerSettingsProvider.notifier);

    const delta = 15;

    final updatedSeconds = timerSettingsNotifier.incrementInitialSecondsBy(delta);

    _resetTimerTo(updatedSeconds);
  }

  void _decrementTimer() {
    final timerSettingsNotifier = ref.read(timerSettingsProvider.notifier);

    const delta = 15;

    final updatedSeconds = timerSettingsNotifier.decrementInitialSecondsBy(delta);

    _resetTimerTo(updatedSeconds);
  }

  void _setInitialSecondsTo(int value) {
    final timerSettingsNotifier = ref.read(timerSettingsProvider.notifier);

    final updatedSeconds = timerSettingsNotifier.setInitialSeconds(value);

    _resetTimerTo(updatedSeconds);
  }

  void _resetTimerTo(int seconds) {
    _resetTimer();

    _timerController.duration = Duration(seconds: seconds);
    _timerCountdownAnimation = IntTween(begin: seconds, end: 0).animate(
      CurvedAnimation(parent: _timerController, curve: Curves.linear),
    );
  }

  void _resetTimer() {
    _timerController.reset();

    _menuOverlayEntry?.markNeedsBuild();
  }
}
