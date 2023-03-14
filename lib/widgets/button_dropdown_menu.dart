import 'package:flutter/material.dart';

class ButtonDropdownMenuItem {
  final String id;
  final Widget? child;
  final Function? onTap;

  const ButtonDropdownMenuItem({
    required this.id,
    this.child,
    this.onTap,
  });
}

class ButtonDropdownMenu extends StatefulWidget {
  static const double menuWidth = 200.0;

  final IconData icon;
  final List<ButtonDropdownMenuItem> items;
  final Duration animationDuration;
  final Curve animationCurve;
  final Function(ButtonDropdownMenuItem)? onSelect;

  const ButtonDropdownMenu({
    Key? key,
    required this.icon,
    required this.items,
    required this.animationDuration,
    required this.animationCurve,
    this.onSelect,
  }) : super(key: key);

  @override
  State<ButtonDropdownMenu> createState() => _ButtonDropdownMenuState();
}

class _ButtonDropdownMenuState extends State<ButtonDropdownMenu> with SingleTickerProviderStateMixin {
  late GlobalKey _key;
  late Offset _buttonPosition;
  late Size _buttonSize;
  OverlayEntry? _menuOverlayEntry;
  OverlayEntry? _backdropOverlayEntry;
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  get isCompletedOrAnimatingForward =>
      _animationController.status == AnimationStatus.completed ||
      _animationController.status == AnimationStatus.forward;

  get isDismissedOrAnimatingReverse =>
      _animationController.status == AnimationStatus.dismissed ||
      _animationController.status == AnimationStatus.reverse;

  get isDismissed => _animationController.status == AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) _removeOverlays();
      });

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
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

  void _closeMenu() {
    if (isDismissedOrAnimatingReverse) return;

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

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Container(
        key: _key,
        child: IconButton(
          icon: Icon(widget.icon),
          color: Theme.of(context).colorScheme.onSurface,
          onPressed: widget.items.isEmpty
              ? null
              : () {
                  // only handle opening the menu, closing is handled by the backdrop.
                  // Also, `isDismissed` check is needed to cover an edge case when
                  // the button is clicked through the backdrop
                  if (isDismissed) _openMenu();
                },
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
        return Positioned(
          top: _buttonPosition.dy + _buttonSize.height,
          left: _buttonPosition.dx + _buttonSize.width - ButtonDropdownMenu.menuWidth - 8.0,
          width: ButtonDropdownMenu.menuWidth,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Opacity(
                opacity: _opacityAnimation.value,
                child: Material(
                  elevation: 2,
                  surfaceTintColor: Theme.of(context).colorScheme.primary,
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(4.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: widget.items.map<Widget>((item) {
                        return MaterialButton(
                          onPressed: () {
                            item.onTap?.call();
                            widget.onSelect?.call(item);

                            _closeMenu();
                          },
                          child: SizedBox(
                            width: ButtonDropdownMenu.menuWidth,
                            height: 40.0,
                            child: Align(alignment: Alignment.centerLeft, child: item.child),
                          ),
                        );
                      }).toList(),
                    ),
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
