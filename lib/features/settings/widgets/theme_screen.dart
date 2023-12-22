import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/go_back_button.dart';
import '../../../widgets/layout.dart';
import 'color_switcher_widget.dart';
import 'theme_switcher_widget.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      centerTitle: false,
      leading: GoBackButton(onPressed: () => context.pop()),
      appBarTitle: Text(
        'Theme',
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      child: const Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ThemeSwitcherWidget(),
          SizedBox(height: 52.0),
          ColorSwitcherWidget(),
        ],
      ),
    );
  }
}
