import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/training_block/widget_params.dart';
import 'reaction.dart';

class ReactionMenu extends ConsumerStatefulWidget {
  static const animationDuration = Duration(milliseconds: 500);
  static const animationCurve = Cubic(0.68, -0.55, 0.27, 1.55);

  final int? selectedReaction;
  final Function(int? value) onSelect;

  const ReactionMenu({
    super.key,
    this.selectedReaction,
    required this.onSelect,
  });

  @override
  ConsumerState createState() => _ReactionMenuState();
}

class _ReactionMenuState extends ConsumerState<ReactionMenu> with SingleTickerProviderStateMixin {
  int? selectedReaction;

  late GlobalKey _key;
  late Offset _buttonPosition;
  late Size _buttonSize;
  OverlayEntry? _menuOverlayEntry;
  OverlayEntry? _backdropOverlayEntry;
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _expandAnimation;

  get isCompletedOrAnimatingForward =>
      _animationController.status == AnimationStatus.completed ||
      _animationController.status == AnimationStatus.forward;

  get isDismissedOrAnimatingReverse =>
      _animationController.status == AnimationStatus.dismissed ||
      _animationController.status == AnimationStatus.reverse;

  get isDismissed => _animationController.status == AnimationStatus.dismissed;

  @override
  void didUpdateWidget(ReactionMenu oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedReaction != selectedReaction) {
      setState(() => selectedReaction = widget.selectedReaction);
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() => selectedReaction = widget.selectedReaction);

    _animationController = AnimationController(
      vsync: this,
      duration: ReactionMenu.animationDuration,
    )..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) _removeOverlays();
      });

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: ReactionMenu.animationCurve,
      ),
    );

    _expandAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: ReactionMenu.animationCurve,
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

  void _selectReaction(int? value) {
    final updatedValue = value == selectedReaction ? null : value;

    _closeMenu(giveHapticFeedback: true);

    setState(() => selectedReaction = updatedValue);

    widget.onSelect(updatedValue);
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
      builder: (context, child) => Container(
        key: _key,
        child: GestureDetector(
          onTap: () {
            // only handle opening the menu, closing is handled separately.
            // Also, `isDismissed` check is needed to cover an edge case when
            // the button is clicked through the backdrop
            if (isDismissed) _openMenu();
          },
          child: Transform.scale(
            scale: 1 + 0.25 * _expandAnimation.value,
            child: Opacity(
              opacity: 1.0 - _expandAnimation.value.clamp(0.0, 1.0),
              child: Reaction(value: widget.selectedReaction),
            ),
          ),
        ),
      ),
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
        final widgetParams = ref.watch(widgetParamsProvider);

        const containerHeightBase = 110.0;
        const containerWidthBase = 75.0;

        final containerHeight = widgetParams.isCompactMode ? containerHeightBase : 1.25 * containerHeightBase;
        final containerWidth = widgetParams.isCompactMode ? containerWidthBase : 1.25 * containerWidthBase;

        return Positioned(
          top: _buttonPosition.dy + _buttonSize.height / 2 - containerHeight / 2,
          left: _buttonPosition.dx + _buttonSize.width - containerWidth,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Opacity(
                opacity: _opacityAnimation.value.clamp(0, 1.0),
                child: SizedBox(
                  height: containerHeight,
                  width: containerWidth,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Transform(
                          origin: Offset(
                            widgetParams.reactionCircleSize / 2,
                            widgetParams.reactionCircleSize / 2,
                          ),
                          transform: Matrix4.identity()..scale(1.0 * _expandAnimation.value),
                          child: GestureDetector(
                            onTap: () => _closeMenu(giveHapticFeedback: true),
                            child: Opacity(
                              opacity: _expandAnimation.value.clamp(0, 1.0),
                              child: Reaction(isCancelState: true, value: null),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Transform(
                          origin: Offset(
                            widgetParams.reactionCircleSize / 2,
                            widgetParams.reactionCircleSize / 2,
                          ),
                          transform: Matrix4.identity()
                            ..scale(1.25 * _expandAnimation.value)
                            ..translate(-0.16 * containerWidth * _expandAnimation.value, -0.25 * containerHeight, 0),
                          child: GestureDetector(
                            onTap: () => _selectReaction(5),
                            child: Reaction(
                              value: 5,
                              isSelected: selectedReaction == 5,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Transform(
                          origin: Offset(
                            widgetParams.reactionCircleSize / 2,
                            widgetParams.reactionCircleSize / 2,
                          ),
                          transform: Matrix4.identity()
                            ..scale(1.25 * _expandAnimation.value)
                            ..translate(-0.4 * containerWidth * _expandAnimation.value, 0, 0),
                          child: GestureDetector(
                            onTap: () => _selectReaction(0),
                            child: Reaction(
                              value: 0,
                              isSelected: selectedReaction == 0,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Transform(
                          origin: Offset(
                            widgetParams.reactionCircleSize / 2,
                            widgetParams.reactionCircleSize / 2,
                          ),
                          transform: Matrix4.identity()
                            ..scale(1.25 * _expandAnimation.value)
                            ..translate(-0.16 * containerWidth * _expandAnimation.value, 0.25 * containerHeight, 0),
                          child: GestureDetector(
                            onTap: () => _selectReaction(-5),
                            child: Reaction(
                              value: -5,
                              isSelected: selectedReaction == -5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
