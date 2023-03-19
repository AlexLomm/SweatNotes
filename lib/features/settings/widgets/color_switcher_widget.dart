import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journal_flutter/widgets/custom_bottom_sheet/custom_bottom_sheet.dart';

import '../../../widgets/button.dart';
import '../../training_block/widget_params.dart';
import '../seed_color_switcher.dart';

class ColorSwitcherWidget extends ConsumerWidget {
  const ColorSwitcherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seedColorSwitcher = ref.watch(seedColorSwitcherProvider.notifier);
    final seedColor = ref.watch(seedColorSwitcherProvider);

    final colors = [
      const Color.fromRGBO(103, 80, 164, 1),
      const Color.fromRGBO(47, 88, 205, 1),
      const Color.fromRGBO(83, 145, 101, 1),
      const Color.fromRGBO(255, 184, 76, 1),
      const Color.fromRGBO(223, 46, 56, 1),
    ];

    return Wrap(
      runSpacing: 16.0,
      spacing: 16.0,
      children: [
        _RainbowCircle(
          color: seedColor,
          isSelected: !colors.contains(seedColor),
          onColorChanged: (color) => seedColorSwitcher.setSeedColor(color),
        ),
        for (final color in colors)
          _ColorCircle(
            color: color,
            isSelected: color == seedColor,
            onTap: () => seedColorSwitcher.setSeedColor(color),
          ),
      ],
    );
  }
}

class _RainbowCircle extends StatefulWidget {
  final Color color;
  final bool isSelected;
  final ValueChanged<Color> onColorChanged;

  const _RainbowCircle({
    Key? key,
    required this.color,
    required this.isSelected,
    required this.onColorChanged,
  }) : super(key: key);

  @override
  State<_RainbowCircle> createState() => _RainbowCircleState();
}

class _RainbowCircleState extends State<_RainbowCircle> {
  late Color _color;

  @override
  void initState() {
    super.initState();
    _color = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    const rainbowBoxDecoration = BoxDecoration(
      shape: BoxShape.circle,
      gradient: SweepGradient(colors: [
        Color.fromRGBO(103, 80, 164, 1),
        Color.fromRGBO(47, 88, 205, 1),
        Color.fromRGBO(83, 145, 101, 1),
        Color.fromRGBO(255, 184, 76, 1),
        Color.fromRGBO(223, 46, 56, 1),
        Color.fromRGBO(103, 80, 164, 1),
      ]),
    );

    return GestureDetector(
      onTap: () => CustomBottomSheet(
        title: 'Select color',
        height: 537.0,
        child: Theme(
          data: Theme.of(context).copyWith(
            textTheme: TextTheme(
              bodyText1: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
              bodyText2: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ColorPicker(
                  pickerAreaHeightPercent: 0.75,
                  enableAlpha: false,
                  portraitOnly: false,
                  paletteType: PaletteType.hueWheel,
                  pickerColor: widget.color,
                  onColorChanged: (color) => setState(() => _color = color),
                ),
                const SizedBox(height: 24.0),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.primary),
                        child: const Text('Cancel'),
                      ),
                    ),
                    Expanded(
                      child: Button(
                        onPressed: () {
                          widget.onColorChanged(_color);

                          Navigator.of(context).pop();
                        },
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text('Set', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ).show(context),
      child: AnimatedContainer(
        duration: WidgetParams.animationDuration,
        curve: WidgetParams.animationCurve,
        width: 40,
        height: 40,
        decoration: widget.isSelected ? rainbowBoxDecoration : const BoxDecoration(shape: BoxShape.circle),
        child: Center(
          child: Container(
            width: 36.0,
            height: 36.0,
            decoration: rainbowBoxDecoration.copyWith(
              border: Border.all(color: Theme.of(context).colorScheme.background, width: 2),
            ),
            child: Center(
              child: Container(
                width: 20.0,
                height: 20.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorCircle extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _ColorCircle({
    Key? key,
    required this.color,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: WidgetParams.animationDuration,
      curve: WidgetParams.animationCurve,
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isSelected ? color : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).colorScheme.background, width: 2),
          ),
          child: MaterialButton(
            color: color,
            shape: const CircleBorder(),
            onPressed: onTap,
          ),
        ),
      ),
    );
  }
}
