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
  static const double menuWidth = 200;

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
  late OverlayEntry _menuOverlayEntry;
  late OverlayEntry _backdropOverlayEntry;
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..addStatusListener((status) {
        // finish the animation and remove the menu overlay
        if (status == AnimationStatus.dismissed && _menuOverlayEntry.mounted) {
          _menuOverlayEntry.remove();
        }
      });

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );

    _key = GlobalKey();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateButtonData() {
    final renderBox = _key.currentContext?.findRenderObject() as RenderBox;
    _buttonSize = renderBox.size;
    _buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  void _closeMenu() {
    // remove the backdrop overlay immediately
    if (_backdropOverlayEntry.mounted) _backdropOverlayEntry.remove();
    _animationController.reverse();

    _isMenuOpen = false;
  }

  void _openMenu() {
    _updateButtonData();

    _backdropOverlayEntry = _backdropOverlayEntryBuilder();
    _menuOverlayEntry = _overlayEntryBuilder();

    Overlay.of(context).insert(_backdropOverlayEntry);
    Overlay.of(context).insert(_menuOverlayEntry);

    _isMenuOpen = true;

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: IconButton(
        icon: Icon(widget.icon),
        color: Theme.of(context).colorScheme.onSurface,
        onPressed: () {
          if (_isMenuOpen) {
            _closeMenu();
          } else {
            _openMenu();
          }
        },
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

  OverlayEntry _overlayEntryBuilder() {
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
                            width: 200.0,
                            height: 40.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: item.child,
                            ),
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
